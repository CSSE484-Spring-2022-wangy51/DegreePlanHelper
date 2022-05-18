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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loginHandle = AuthManager.shared.addLoginObserver {
//            self.performSegue(withIdentifier: kShowDetailSegue, sender: self)
//        }
//        AuthManager.shared.loginObserver = {
//            print("log state changed")
//            self.performSegue(withIdentifier: kShowPlanTableView, sender: self)
//        }
    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        AuthManager.shared.removeObserver(loginHandle)
//    }
//
//    @IBAction func pressCreateUser(_ sender: Any) {
//    }
    @IBAction func pressLogIn(_ sender: Any) {
       
        if(EmailText.text!.range(of: "@", options: .caseInsensitive) != nil){
            AuthManager.shared.loginExistingEmailPasswordUser(email: EmailText.text!, password: PasswordField.text!)
            
        }else{
        
        
        AuthManager.shared.loginExistingUser(UserName: EmailText.text!, password: PasswordField.text!)
        
//        if(flag == true){
//            AuthManager.shared.isSignedIn = true
//            print("login successed")
//            performSegue(withIdentifier: kShowPlanTableView, sender: self)
//        }else{
//            AuthManager.shared.isSignedIn = false
//            print("login faild")
//        }
            }
        self.dismiss(animated: true)
    }
    
    @IBAction func pressRoseLogin(_ sender: Any) {
//        print("pressed rosefire login")
//        print(" Use Rosefire")
//
//        Rosefire.sharedDelegate().uiDelegate = self // This should be your view controller
//        Rosefire.sharedDelegate().signIn(registryToken: kRosefireRegToken) { (err, result) in
//          if let err = err {
//            print("Rosefire sign in error! \(err)")
//            return
//          }
////          print("Result = \(result!.token!)")
////          print("Result = \(result!.username!)")
//        print("Result = \(result!.name!)")
////        self.rosefireName = result!.name!
////          print("Result = \(result!.email!)")
////          print("Result = \(result!.group!)")
//            AuthManager.shared.signInWithRosefireToken(result!.token)
//
//        }
    }
    
    
//    @IBAction func pressedCreatedNewUser(_ sender: Any) {
//        
//        let flag = AuthManager.shared.registerNewUser(email: EmailText.text!, password: PasswordField.text!)
//        if(flag == true){
//            AuthManager.shared.isSignedIn = true
//            print("create and login successed")
//            performSegue(withIdentifier: kShowPlanTableView, sender: self)
//        }else{
//            AuthManager.shared.isSignedIn = false
//            print("create user faild")
//        }
//    }
    
    
}
