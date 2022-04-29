//
//  PlansTableViewController.swift
//  SQLClient
//
//  Created by Qijun Jiang on 2022/4/28.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class PlanCell: UITableViewCell{
    
}


class PlansTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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
        tableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPlanCell, for: indexPath)


        // Configure the cell...

        cell.textLabel!.text = "Plan name"

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit,
//                                                                 target: self,
//                                                                 action: #selector(showEditQuoteDialog))
////        updateView()
//
//    }
//
//
//
//        //if viewDidLoad crashes, I could do this
////    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////        updateView()
////    }
//
////    func updateView(){
////        quoteLabel.text = movieQuote.quote
////        movieLabel.text = movieQuote.movie
////    }
//
//    @objc func showEditQuoteDialog(){
//
//
//        let alertController = UIAlertController(title: "Edit movie quote",
//                                                message: "",
//                                                preferredStyle: UIAlertController.Style.alert)
//
////        alertController.addTextField { textField in
////            textField.placeholder = "Quote"//the grey word
////            textField.text = self.movieQuote.quote
////        }
////
////        alertController.addTextField { textField in
////            textField.placeholder = "Movie"//the grey word
////            textField.text = self.movieQuote.movie
////        }
//
//        //create an action and add it to the controller
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
//            print("You pressed cancel")
//        }
//        alertController.addAction(cancelAction)
//
//        //positive button
//        let editQuoteAction = UIAlertAction(title: "Edit quote", style: UIAlertAction.Style.default) { action in
//
////            let quoteTextField = alertController.textFields![0] as UITextField
////            let movieTextField = alertController.textFields![1] as UITextField
////            print("Quote: \(quoteTextField.text!)")
////            print("Movie: \(movieTextField.text!)")
////
////            self.movieQuote.quote = quoteTextField.text!
////            self.movieQuote.movie = movieTextField.text!
////            self.updateView()
//
//        }
//        alertController.addAction(editQuoteAction)
//
//        present(alertController, animated: true)//to show the thing
//    }
}
