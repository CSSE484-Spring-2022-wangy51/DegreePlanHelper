//
//  TagDetailViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/17/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class TagDetailViewController: UIViewController {

    @IBOutlet weak var tagNameTextField: UITextField!
    @IBOutlet weak var tagPlansTextField: UITextField!
    
    var currentTag: Tag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressedUpdate(_ sender: Any) {
        let planList = tagPlansTextField.text!.components(separatedBy: ", ")
        var planDic  = [String:Int]()
        PlanListCollectionManager.shared.getData {
            for p in planList{
                planDic[p] = PlanListCollectionManager.shared.nameToID[p]
            }
            TagManager.shared.update(documentID: (self.currentTag?.documentID)!, tagName: self.tagNameTextField.text!, plans: planDic)
           
        }
    }
    
    func updateView(){
        tagNameTextField.text = currentTag?.tagName
        let textString = currentTag?.planName.map { $0.0}.joined(separator: ", ")
        tagPlansTextField.text = textString
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
