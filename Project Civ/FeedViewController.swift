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
    
    var selectedProject: Project?
    
    let loader = StaticDataLoader()
    
    let interactor = Interactor()
    
    let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProjectSource.sharedInstance.fetchProjects(longitude: 10, latitude: 10) { (projects) in
            print(projects!)
            self.projects = projects!
            self.adapter.reloadData(completion: nil)
        }

//        loader.load()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
//        tabBarController?.edgesForExtendedLayout = []
        navigationController?.edgesForExtendedLayout = []
//        edgesForExtendedLayout = []
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(hex6: 0xEEEEEE)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewProjectPressed))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.setCustomTitleView(title: "FEED")

        view.layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewProjectPressed() {
        let addProjectController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddProjectViewController") as! AddProjectViewController
        let navigationCont = UINavigationController(rootViewController: addProjectController)
        navigationCont.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss(animated:completion:)))
        navigationCont.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss(animated:completion:)))
//        projectController.projectSelected = project
        navigationController?.present(navigationCont, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ProjectViewController {
            destinationViewController.projectSelected = selectedProject!
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
        }
    }
    
    @IBAction func unwindToFeed(segue: UIStoryboardSegue) {}

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
//        var items = loader.projects as [IGListDiffable]
//        items += loader.updates as [IGListDiffable]
        return projects as [IGListDiffable]
    }
    
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
//        if object is Project {
            let feedController = FeedProjectInfoSectionController()
            feedController.delegate = self
            return feedController
//        } else {
//            let updateController = ProjectUpdateSectionController()
//            return updateController
//        }
    }
    
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
}

extension FeedViewController: FeedProjectInfoSectionControllerDelegate {
    func projectSelected(_ project: Project) {
        selectedProject = project
        // instantiate
//        let projectController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProjectViewController") as! ProjectViewController
//        projectController.projectSelected = project
//        self.present(projectController, animated: true, completion: nil)
        performSegue(withIdentifier: "showProjectControllerSegue", sender: nil)
    }
}


extension FeedViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

