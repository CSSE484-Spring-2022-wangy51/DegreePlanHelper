//
//  PlanListSideMenuViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class PlanListSideMenuViewController: UIViewController {

    var tableViewController: PlansTableViewController{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! PlansTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressedProfile(_ sender: Any) {
        dismiss(animated: true)
        tableViewController.isEditing = false
        tableViewController.performSegue(withIdentifier: kShowProfleSegue, sender: tableViewController)
    }
    
    
    @IBAction func pressedDeletePlan(_ sender: Any) {
        dismiss(animated: true)
        tableViewController.isEditing = !tableViewController.isEditing
    }
    
    @IBAction func pressedFilterByTags(_ sender: Any) {
//        dismiss(animated: true)
        tableViewController.isEditing = false
        filterByTagDialog()
    }
    
    @IBAction func pressedLogOut(_ sender: Any) {
        dismiss(animated: true)
        tableViewController.isEditing = false
        AuthManager.shared.logout()
    }
    
    @IBAction func pressedAddTag(_ sender: Any) {
        tableViewController.isEditing = false
        showAddTagDialog()
    }
    
    @IBAction func pressedDeleteTag(_ sender: Any) {
    }
    
    func showAddTagDialog(){
//        print("you pressed the add button")
        
        let alertController = UIAlertController(title: "Add tag to plans ",
                                                message: "",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "tag name"//the grey word
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "plans"//the grey word
        }
        
        //create an action and add it to the controller
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            print("You pressed cancel")
        }
        alertController.addAction(cancelAction)
        
        //positive button
        let createTagAction = UIAlertAction(title: "Create tag", style: UIAlertAction.Style.default) { action in
            print("You pressed create tag")
            
            let tagNameTextField = alertController.textFields![0] as UITextField
            let plansTextField = alertController.textFields![1] as UITextField
//            print("Quote: \(quoteTextField.text!)")
//            print("Movie: \(movieTextField.text!)")
            
            let planList = plansTextField.text!.components(separatedBy: ", ")
//            let t = Tag(authID: AuthManager.shared.currentUser!.uid, planNames: planList, tagName: tagNameTextField.text!)
//            TagManager.shared.add(t)
            
        }
        alertController.addAction(createTagAction)
        
        present(alertController, animated: true)//to show the thing
    }
    
    func filterByTagDialog(){
//        print("you pressed the add button")
        
        let alertController = UIAlertController(title: "Fiter by tag ",
                                                message: "",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "tag names"//the grey word
        }
        
        //create an action and add it to the controller
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            print("You pressed cancel")
        }
        alertController.addAction(cancelAction)
        
        //positive button
        let filterByTagAction = UIAlertAction(title: "Filter by tag", style: UIAlertAction.Style.default) { action in
            print("You pressed create tag")
            
            let tagNamesTextField = alertController.textFields![0] as UITextField
            
            let tagList = tagNamesTextField.text!.components(separatedBy: ", ")
            self.tableViewController.tagFilter = tagList
//            self.tableViewController.startListening()
            
            
        }
        alertController.addAction(filterByTagAction)
        
        present(alertController, animated: true)//to show the thing
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
