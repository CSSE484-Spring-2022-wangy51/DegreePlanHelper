//
//  PlanListCollectionManager.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import Pods_SQLClient


class PlanListCollectionManager{
    
    static let shared = PlanListCollectionManager()
    private init(){
        
    }
    var plans = [Plan]()
    var tagFilter = [String]()
    var nameToID = [String:Int]()
    
    func getData( changeListener: @escaping (() -> Void)){
        self.plans.removeAll()
        var query = ""
        query = "SELECT [Plan].Name AS PlanName, PlanID FROM Person JOIN Student ON Student.StudentID = Person.PersonID JOIN [Plan] ON [Plan].StudentID = Student.StudentID WHERE Person.PersonID = \(AuthManager.shared.currentUser!.uid)"
        print("query: \(query)")
        print("filter by : \(tagFilter)")
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(query, completion: { (_ results: ([Any]?)) in
            if let r = results as? [[[String:AnyObject]]]{
                for table in r {//results as! [[[String:AnyObject]]]
                    
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
//                        print("pid:\(pid), name:\(pName)")
                            let p = Plan(pid: pid, pName: pName)
                            self.plans.append(p)
                            self.nameToID[pName] = pid
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
    
    func add(pName: String, changeListener: @escaping (() -> Void)){
        //TODO: return the added pid and pName
        //TODO: add query
        let client = SQLClient.sharedInstance()!
                client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
                    let query = "DECLARE @output int  EXEC [insertNewPlan] '\(pName)', \((AuthManager.shared.currentUser?.uid)!), @output OUTPUT SELECT @output AS result"
                    print("add plan query: \(query)")
                  client.execute(query, completion: { (_ results: ([Any]?)) in
                      if let r = results as? [[[String:AnyObject]]] {
                       for table in r {
                           for row in table {
                               
                               var pid = 0
                               for (columnName, value) in row {
                                   print("Plan: \(columnName) = \(value)")
                                   pid = value as! Int
                                   
                               }
                               print("pid:\(pid), name:\(pName)")
//                               let p = Plan(pid: pid, pName: pName)
//                               self.plans.append(p)
                               print("going to run changeListener")
                               changeListener()
                           }
                       }
                      }else{
                          print("no return from database")
                    }
                      
                   client.disconnect()
               })
           }
        }
    
    func delete(pid: Int, changeListener: @escaping (() -> Void)){
    
        let client = SQLClient.sharedInstance()!
                client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
                    let query = "DECLARE @output int  EXEC [deletePlan] \(pid), \((AuthManager.shared.currentUser?.uid)!), @output OUTPUT SELECT @output AS result"
                    print("delete query\(query)")
                  client.execute(query, completion: { (_ results: ([Any]?)) in
                      if let r = results as? [[[String:AnyObject]]] {
                       for table in r {
                           for row in table {
                               for (columnName, value) in row {
                                   print("\(columnName) = \(value)")
                                   let v = value as! Int
                                   if(v == 1){
                                       print("successfully deleted")
                                       changeListener()
                                   }else{
                                       print("fail delete")
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
    
    func getIdFromName(pName: String, changeListener: @escaping (() -> Void)){
        
    }
    
    }
    
    
    

