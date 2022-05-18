//
//  PlanDetailSideMenuViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class PlanDetailSideMenuViewController: UIViewController {
    
    var tableViewController: PlanDetailCollectionViewController{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! PlanDetailCollectionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func pressedAddCourse(_ sender: Any) {
        self.dismiss(animated: true)
        print("pressed add course")
        tableViewController.performSegue(withIdentifier: kShowAddCourseViewSegue, sender: tableViewController)
        
    }
    
    @IBAction func pressedBackToPlans(_ sender: Any) {
        self.dismiss(animated: true)
        tableViewController.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if (segue.identifier == kShowAddCourseViewSegue){
//            print("going to give pid: \(tableViewController.pID)")
//            let dvc = segue.destination as! AddCourseViewController
//            dvc.currentPlanID = tableViewController.pID
//
//        }
//    }
    

}
