//
//  PlansTableViewController.swift
//  SQLClient
//
//  Created by Qijun Jiang on 2022/4/28.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit
import Pods_SQLClient

class PlansTableViewController: UITableViewController {

    var plans = [Plan]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action:  #selector(showAddPlanDialog))
        
        

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
        getData()
        tableView.reloadData()
       
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return self.plans.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPlanCell, for: indexPath)


        // Configure the cell...

        cell.textLabel!.text = self.plans[indexPath.row].pName

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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
    func getData(){
        var query = ""
        query = "SELECT [Plan].Name AS PlanName, PlanID FROM Person JOIN Student ON Student.StudentID = Person.PersonID JOIN [Plan] ON [Plan].StudentID = Student.StudentID WHERE Person.PersonID = \(AuthManager.shared.currentUser!.uid)"
        print("query: \(query)")
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(query, completion: { (_ results: ([Any]?)) in
               
                for table in results as! [[[String:AnyObject]]] {
                    for row in table {
                        var pName = ""
                        var pid = 0
                        for (columnName, value) in row {
                            print("Plan: \(columnName) = \(value)")
                            if(columnName == "PlanName"){
                                pName = value as! String
                            }else{
                                pid = value as! Int
                            }
                            
                        }
                        print("pid:\(pid), name:\(pName)")
                        let p = Plan(pid: pid, pName: pName)
                        self.plans.append(p)
                        self.tableView.reloadData()
                    }
                }
                
                client.disconnect()
            })
        }
    }
    
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
