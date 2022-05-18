//
//  TagsTableViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/17/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit
import FirebaseFirestore

class TagsTableViewController: UITableViewController {
    
    var listenerRegistration: ListenerRegistration?
    
    var tableViewController: PlansTableViewController{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! PlansTableViewController
    }
    
    var isSelecting: Bool?
    var tagToPass: Tag?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                                 target: self,
                                                                 action: #selector(showAddTagDialog))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startListening()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopListening()
    }
    
    func startListening(){
        stopListening()
        listenerRegistration = TagManager.shared.startListening(filterByAuthor: AuthManager.shared.currentUser!.uid) {
            self.tableView.reloadData()
        }
    }
    
    func stopListening(){
        TagManager.shared.stopListening(listenerRegistration)
    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        self.isEditing = true
//        return UISwipeActionsConfiguration()
//    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
        // Perform your action here
//          self.isEditing = true
          let docID = TagManager.shared.latestTags[indexPath.row].documentID!
          TagManager.shared.delete(docID)
          self.tableView.reloadData()
          completion(true)
      }

      
      return UISwipeActionsConfiguration(actions: [deleteAction])
    }
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        self.isEditing = false
//        return UISwipeActionsConfiguration()
//    }
    
    @objc func showAddTagDialog(){
//        print("you pressed the add button")
        
        let alertController = UIAlertController(title: "Create a new Tag",
                                                message: "",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Tag Name"//the grey word
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Plan Names"//the grey word
        }
        
        //create an action and add it to the controller
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            print("You pressed cancel")
        }
        alertController.addAction(cancelAction)
        
        //positive button
        let createAlbumAction = UIAlertAction(title: "Create Tag", style: UIAlertAction.Style.default) { action in
            print("You pressed create Tag")
            
            let tagNameTextField = alertController.textFields![0] as UITextField
            let plansTextField = alertController.textFields![1] as UITextField
            let planList = plansTextField.text!.components(separatedBy: ", ")
            var planDic  = [String:Int]()
            PlanListCollectionManager.shared.getData {
                for p in planList{
                    planDic[p] = PlanListCollectionManager.shared.nameToID[p]
                }
                let t = Tag(authID: AuthManager.shared.currentUser!.uid, planName: planDic, tagName: tagNameTextField.text!)
                TagManager.shared.add(t)
                self.tableView.reloadData()
            }
            
           
        }
        alertController.addAction(createAlbumAction)
        
        present(alertController, animated: true)//to show the thing
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TagManager.shared.latestTags.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTagCell, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = TagManager.shared.latestTags[indexPath.row].tagName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.isSelecting!){
//            print("taped row \(indexPath.row)")
            let plans = TagManager.shared.latestTags[indexPath.row].planName
            PlanListCollectionManager.shared.plans.removeAll()
            for p in plans{
                let tp = Plan(pid: p.value, pName: p.key)
                PlanListCollectionManager.shared.plans.append(tp)
            }
            print("new list: \(PlanListCollectionManager.shared.plans)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            self.dismiss(animated: true)
        }else{
            tagToPass = TagManager.shared.latestTags[indexPath.row]
            performSegue(withIdentifier: kShowTagContentSegue, sender: self)
        }
    }
    

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            let docID = TagManager.shared.latestTags[indexPath.row].documentID!
//            TagManager.shared.delete(docID)
//        }
//    }
    

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
        if (segue.identifier == kShowTagContentSegue){
            let dvc = segue.destination as! TagDetailViewController
            dvc.currentTag = self.tagToPass
        }
    }
    

}
