//
//  LoginViewController.swift
//  SQLClient
//
//  Created by Yujie Zhang on 4/28/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
//    var rosefireName: String?
//    var loginHandle: AuthStateDidChangeListenerHandle?
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailTextField.placeholder = "Email"
//        passwordTextField.placeholder = "Password"
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        loginHandle = AuthManager.shared.addLoginObserver {
//            self.performSegue(withIdentifier: kShowDetailSegue, sender: self)
//        }
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        AuthManager.shared.removeObserver(loginHandle)
//    }
//
//    @IBAction func pressCreateUser(_ sender: Any) {
//    }
    @IBAction func pressLogIn(_ sender: Any) {
        
        let flag = AuthManager.shared.loginExistingUser(email: EmailText.text!, password: PasswordField.text!)
        if(flag == true){
            AuthManager.shared.isSignedIn = true
            print("login successed")
            performSegue(withIdentifier: kShowPlanTableView, sender: self)
        }else{
            AuthManager.shared.isSignedIn = false
            print("login faild")
        }
        
    }
    @IBAction func pressRoseLogin(_ sender: Any) {
        print("pressed rosefire login")
    }
    
    
    @IBAction func pressedCreatedNewUser(_ sender: Any) {
        
        let flag = AuthManager.shared.registerNewUser(email: EmailText.text!, password: PasswordField.text!)
        if(flag == true){
            AuthManager.shared.isSignedIn = true
            print("create and login successed")
            performSegue(withIdentifier: kShowPlanTableView, sender: self)
        }else{
            AuthManager.shared.isSignedIn = false
            print("create user faild")
        }
    }
    
    
}
