//
//  UserDocumentManager.swift
//  SQLClient
//
//  Created by Helen Wang on 5/14/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import Pods_SQLClient
import FirebaseFirestore

class UserDocumentManager{
    
    static let shared = UserDocumentManager()
    init(){
        
    }
    
    func getUserInfo(uid: Int, changeListener: @escaping (() -> Void)){
        let client = SQLClient.sharedInstance()!
                client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
                    let query = "SELECT * FROM getPersonInfo(\((AuthManager.shared.currentUser?.uid)!)) "
                    print("get info query\(query)")
                  client.execute(query, completion: { (_ results: ([Any]?)) in
                      if let r = results as? [[[String:AnyObject]]] {
                       for table in r {
                           for row in table {
                               let user = AuthManager.shared.currentUser
                               for (columnName, value) in row {
                                   print("\(columnName) = \(value)")
                                   switch columnName{
                                    case "FirstName":
                                       user?.firstName = value as? String ?? ""
                                   case "LastName":
                                      user?.lastName = value as? String ?? ""
                                   case "UserName":
                                      user?.userName = value as? String ?? ""
                                   case "Role":
                                      user?.role = value as? String ?? ""
                                   case "Rank":
                                      user?.rank = value as? String ?? ""
                                   default:
                                       print("exception colum: \(columnName)")
                                   }
                               }
                           }
                       }
                      }else{
                          print("no return from database")
                    }
                    changeListener()
                   client.disconnect()
               })
           }
    }
    
    func updateUser(uid: Int, firstName: String, lastName: String, rank: String){
        let client = SQLClient.sharedInstance()!
                client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
                    let query = "Declare @output int EXEC [updatePerson] \(uid),'\(firstName)', '\(lastName)','\(rank)', @output OUTPUT Select @output AS [output]"
                    print("get info query\(query)")
                  client.execute(query, completion: { (_ results: ([Any]?)) in
                      if let r = results as? [[[String:AnyObject]]] {
                       for table in r {
                           for row in table {
                               let user = AuthManager.shared.currentUser
                               for (columnName, value) in row {
                                   print("\(columnName) = \(value)")
                                   if(value as! Int == 1){
                                       print("update success")
                                      
                                   }else{
                                       print("update fail")
                                   }
                               }
                           }
                       }
                      }else{
                          print("no return from database")
                    }
                 
                   client.disconnect()
               })
           }
    }
    
    func createNewUser(firebaseID: String, sqlID: Int){
//        Firestore.firestore().collection(kUsersCollectionPath).addDocument(data: [
//            kFirebaseID: firebaseID,
//            ksqlID: sqlID,
//        ]){err in
//            if let err = err {
//                print("Error adding document \(err)")
//            }
//        }
        
        let docRef = Firestore.firestore().collection(kUsersCollectionPath).document(firebaseID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Document exist, do nothing, here is the data: \(document.data())")
            } else {
                print("Document does not exist, create this user")
                docRef.setData([
                    ksqlID: sqlID,
                ])
            }
        }
    }
    
    
    
    
}
