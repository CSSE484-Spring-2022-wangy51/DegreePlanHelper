//
//  AuthManager.swift
//  SQLClient
//
//  Created by Yujie Zhang on 4/28/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import Pods_SQLClient

class AuthManager{
    static let shared = AuthManager()
    private init(){
        
    }
    var currentUser: User?
    
    var isSignedIn: Bool = false
    
    var loginObserver: (()->Void)?
    
    
    func registerNewUser(role: String, firstName: String, lastName: String, userName: String, password: String, rank:String){//return true if signed in
        //TODO: return 0 for error
        let client = SQLClient.sharedInstance()!
        var loginQuery = ""
        if(role == "s"){
            loginQuery = "Declare @newID int EXECUTE [insertNewUser] '\(role)', '\(firstName)', '\(lastName)','\(userName)', '\(password)', null, @newID OUTPUT Select @newID"
        }else if(role == "p"){
            loginQuery = "Declare @newID int EXECUTE [insertNewUser] @Role = '\(role)', @FName = '\(firstName)', @LName = '\(lastName)', @UserName = '\(userName)', @UserPassword = '\(password)', @Rank = 'test', @UserID = @newID OUTPUT Select @newID"
        }
//        print("LoginQuery = \(loginQuery)")
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(loginQuery, completion: { (_ results: ([Any]?)) in
                
                for table in results as! [[[String:AnyObject]]] {
                    for row in table {
                        for (columnName, value) in row {
                            print("\(columnName) = \(value)")
                            let uid = value as! Int
                            if(uid != -1){
                                self.currentUser = User(uid: uid)
                                self.loginObserver!()
                            }else{
                                print("error register")
                            }
                        }
                    }
                }
                
                client.disconnect()
            })
        }
        
       
    }
    
    func loginExistingUser(UserName: String, password: String){// return true if logged in
       //TODO: return uid
        
        var loginQuery = ""
        loginQuery = "DECLARE @output int EXEC [CheckUser] '\(UserName)','\(password)', @output OUTPUT SELECT @output"
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(loginQuery, completion: { (_ results: ([Any]?)) in
               
                for table in results as! [[[String:AnyObject]]] {
                    for row in table {
                        for (columnName, value) in row {
                            print("\(columnName) = \(value)")
                            let r = value as! Int
                            if(r != -1){
                                self.loginObserver!()
                                self.currentUser = User(uid: r)
                            }else{
                                print("error login")
                            }
                            
                        }
                    }
                }
                
                client.disconnect()
            })
        }
       
    }
    
    
    
    
}
