//
//  PlansTableViewController.swift
//  SQLClient
//
//  Created by Qijun Jiang on 2022/4/28.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit
import Pods_SQLClient
import FirebaseFirestore

class PlansTableViewController: UITableViewController {
    
//    var listenerRegistration: ListenerRegistration?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action:  #selector(showAddPlanDialog))
        AuthManager.shared.loginObserver = {
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                                 target: self,
                                                                 action: #selector(showAddPlanDialog))
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)

       
        

    }
    @objc func doThisWhenNotify(notification : NSNotification) {
        
        //update tableview
        print("din")
        self.tableView.reloadData()

    }

//    @objc func showAddPlanDialog(){
//        print("you pressed add")
//    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        startListening()
        PlanListCollectionManager.shared.getData {
            self.tableView.reloadData()
        }
        
       
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        stopListening()
        PlanListCollectionManager.shared.tagFilter.removeAll()
        
    }
    
//    func startListening(){
//        stopListening()
//        TagManager.shared.startListening(filterByAuthor: AuthManager.shared.currentUser!.uid, filterByTags: PlanListCollectionManager.shared.tagFilter){
//
//            PlanListCollectionManager.shared.getData {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    func stopListening(){
//        TagManager.shared.stopListening(listenerRegistration)
//    }

    @objc func showAddPlanDialog(){
//        print("you pressed the add button")
        
        let alertController = UIAlertController(title: "Create a new Plan",
                                                message: "",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Plam Name"//the grey word
        }
        
        
        //create an action and add it to the controller
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            print("You pressed cancel")
        }
        alertController.addAction(cancelAction)
        
        //positive button
        let createAlbumAction = UIAlertAction(title: "Create Plan", style: UIAlertAction.Style.default) { action in
            print("You pressed create Plan")
            
            let planNameTextField = alertController.textFields![0] as UITextField
            
            PlanListCollectionManager.shared.add(pName: planNameTextField.text!){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    print("Async after 2 seconds")
                    PlanListCollectionManager.shared.getData {
                        self.tableView.reloadData()
                    }
                }
            }
            
          
        }
        alertController.addAction(createAlbumAction)
        
        present(alertController, animated: true)//to show the thing
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return PlanListCollectionManager.shared.plans.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPlanCell, for: indexPath)


        // Configure the cell...
        cell.textLabel!.text = PlanListCollectionManager.shared.plans[indexPath.row].pName
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let pid = PlanListCollectionManager.shared.plans[indexPath.row].pid
            PlanListCollectionManager.shared.delete(pid: pid){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    PlanListCollectionManager.shared.getData {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Prepare to go")
       
//        if segue.identifier == kShowPlanDetailTableViewSegue{
//
//            print("Go to plan detail")
//        }
    }
    
    
    
}
