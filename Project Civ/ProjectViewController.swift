//
//  ProjectViewController.swift
//  Project Civ
//
//  Created by Carlos Arcenas on 2/18/17.
//  Copyright © 2017 Rogue Three. All rights reserved.
//

import UIKit
import IGListKit

class ProjectViewController: UIViewController {

    var interactor: Interactor? = nil
    var projectSelected: Project?
    
    let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

//    var updates = [ProjectUpdate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        ProjectSource.sharedInstance.fetchUpdatesForProject(projectSelected!) { (updates) in
            self.projectSelected!.updates = updates!
            self.adapter.reloadData(completion: nil)
        }
        
        view.backgroundColor = UIColor(hex6: 0xEEEEEE)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }

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

//
extension ProjectViewController: IGListAdapterDataSource {
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items = [projectSelected!] as [IGListDiffable]
        items += projectSelected!.updates as [IGListDiffable]
        return items
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is Project {
            return ProjectCoverSectionController()
        } else {
            return ProjectUpdateSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

extension ProjectViewController: ProjectCoverSectionControllerDelegate {
    func closeTapped() {
//        presentingViewController?.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "unwindToFeedSegue", sender: self)
    }
    
    func infoTapped() {
        let projectInfoController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProjectInfoViewController") as! ProjectInfoViewController
        projectInfoController.projectSelected = projectSelected!
        let navCon = UINavigationController(rootViewController: projectInfoController)
        self.present(navCon, animated: true, completion: nil)
    }
}
