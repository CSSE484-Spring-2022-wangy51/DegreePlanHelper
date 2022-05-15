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
    var r: Int?
    
    var loginObserver: (()->Void)?
    
    
    func registerNewUser(role: String, firstName: String, lastName: String, userName: String, password: String, rank:String) -> Bool{//return true if signed in
        //TODO: insert new record to users table, return 1 if success executed
        
        let client = SQLClient.sharedInstance()!
        var loginQuery = ""
        if(role == "s"){
            loginQuery = "Declare @newID int EXECUTE [insertNewUser] '\(role)', '\(firstName)', '\(lastName)','\(userName)', '\(password)', null, @newID OUTPUT Select @newID"
        }else if(role == "p"){
            loginQuery = "Declare @newID int EXECUTE [insertNewUser] @Role = '\(role)', @FName = '\(firstName)', @LName = '\(lastName)', @UserName = '\(userName)', @UserPassword = '\(password)', @Rank = 'test', @UserID = @newID OUTPUT Select @newID"
        }else{
            return false
        }
        print("LoginQuery = \(loginQuery)")
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(loginQuery, completion: { (_ results: ([Any]?)) in
                
                for table in results as! [[[String:AnyObject]]] {
                    for row in table {
                        for (columnName, value) in row {
                            print("\(columnName) = \(value)")
                        }
                    }
                }
                
                client.disconnect()
            })
        }
        
        return true
    }
    
    func loginExistingUser(UserName: String, password: String) -> Bool{// return true if logged in
        //TODO: search for this tuple, if exist return the useremail as current user id, else return "No user"
        //TODO: set var current user to the return id or nil
        
        var loginQuery = ""
        loginQuery = "Declare @Validity int EXECUTE [CheckUser] @UserName = '\(UserName)', @Password = '\(password)',@Valid = @Validity OUTPUT Select @Validity"
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(loginQuery, completion: { (_ results: ([Any]?)) in
                
                for table in results as! [[[String:AnyObject]]] {
                    for row in table {
                        for (columnName, value) in row {
                            print("\(columnName) = \(value)")
                            self.r = value as! Int
                            print("r1: \(self.r)")
                            if(self.r == 1){
                                self.loginObserver!()
                            }else{
                                print("error login")
                            }
                            
                        }
                    }
                }
                
                client.disconnect()
            })
        }
        print("r2: \(self.r)")
        
        return true
    }
    
    
    
    
}
