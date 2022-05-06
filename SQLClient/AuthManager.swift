//
//  AuthManager.swift
//  SQLClient
//
//  Created by Yujie Zhang on 4/28/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation

class AuthManager{
    static let shared = AuthManager()
    private init(){
        
    }
    var currentUser: String?
    
    var isSignedIn: Bool{
      currentUser != nil
    }
    
    func registerNewUser(email: String, password: String){
        //TODO: insert new record to users table
    }
    
    func loginExistingUser(email: String, password: String){
        //TODO: search for this tuple, if exist return the useremail as current user id, else return "No user"
        //TODO: set var current user to the return, id or nil
    }
    
    
}
