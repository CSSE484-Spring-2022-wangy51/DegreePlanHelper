//
//  ProfileViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDocumentManager.shared.getUserInfo(uid: AuthManager.shared.currentUser!.uid)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDocumentManager.shared.getUserInfo(uid: AuthManager.shared.currentUser!.uid){
            self.updateView()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    

    @IBAction func pressedSaveChanges(_ sender: Any) {
        UserDocumentManager.shared.updateUser(uid: AuthManager.shared.currentUser!.uid, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, rank: rankTextField.text ?? "") 
        
    }
    
    func updateView(){
        userNameLabel.text = AuthManager.shared.currentUser?.userName
        firstNameTextField.text = AuthManager.shared.currentUser?.firstName
        lastNameTextField.text = AuthManager.shared.currentUser?.lastName
        if(AuthManager.shared.currentUser?.role == "s"){
            rankLabel.isHidden = true
            rankTextField.isHidden = true
        }else{
            rankTextField.text = AuthManager.shared.currentUser?.rank
        }
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
