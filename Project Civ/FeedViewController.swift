//
//  FeedViewController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

// Implementation of IGListCollectionView adapted from raywenderlich.com/147162/iglistkit-tutorial-better-uicollectionviews

import UIKit
import IGListKit

class FeedViewController: UIViewController {
    
    let loader = StaticDataLoader()
    
    let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        loader.load()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        tabBarController?.edgesForExtendedLayout = []
        
        tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor(hex6: 0xE83151)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        edgesForExtendedLayout = []
        super.viewDidAppear(animated)
        tabBarController?.setCustomTitleView(title: "FEED")
        view.layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        let items = loader.projects as [IGListDiffable]
//        items += loader.projects as [IGListDiffable]
        return items
    }
    
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
            return FeedProjectInfoSectionController()

    }
    
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
}
