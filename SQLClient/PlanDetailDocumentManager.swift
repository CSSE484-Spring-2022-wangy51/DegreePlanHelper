//
//  PlanDetailDocumentManager.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import Pods_SQLClient
class PlanDetailDocumentManager{
    
    static let shared = PlanDetailDocumentManager()
    init(){
        
    }
    
    
    var yqToSecNum = [String: Int]()
    var selectedCourse = CourseDetail(courseNumber: "", courseName: "", creditHour: 0.0, preCourse: [String](), major: [String](), dep: [String]())
    
    func initailize(){
        setMap()
        initializeTable()
    }
    
    func setMap(){
        yqToSecNum["Freshman Fall"] = 0
        yqToSecNum["Freshman Winter"] = 1
        yqToSecNum["Freshman Spring"] = 2
        yqToSecNum["Freshman Summer"] = 3
        
        yqToSecNum["Sophomore Fall"] = 4
        yqToSecNum["Sophomore Winter"] = 5
        yqToSecNum["Sophomore Spring"] = 6
        yqToSecNum["Sophomore Summer"] = 7
        
        yqToSecNum["Junior Fall"] = 8
        yqToSecNum["Junior Winter"] = 9
        yqToSecNum["Junior Spring"] = 10
        yqToSecNum["Junior Summer"] = 11
        
        yqToSecNum["Senior Fall"] = 12
        yqToSecNum["Senior Winter"] = 13
        yqToSecNum["Senior Spring"] = 14
        yqToSecNum["Senior Summer"] = 15
        
        yqToSecNum["SuperSenior Fall"] = 16
        yqToSecNum["SuperSenior Winter"] = 17
        yqToSecNum["SuperSenior Spring"] = 18
        yqToSecNum["SuperSenior Summer"] = 19
    }
    var courseTable = [Int: [String]]()
    var planID: Int?
    
    func initializeTable(){
        let initArray = ["","","","","","",""]
        for i in 0...19{
            courseTable[i] = initArray
        }
    }
    
    func getData(planID:Int, changeListener: @escaping (() -> Void)){
        var query = ""
        query = "SELECT * FROM CourseNameInPlan(\(planID))"
//        print("query: \(query)")
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(query, completion: { (_ results: ([Any]?)) in
            if let r = results as? [[[String:AnyObject]]]{
                for table in r {//results as! [[[String:AnyObject]]]
                    
                    for row in table {
                        var year = ""
                        var quarter = ""
                        var courseNum = ""
                        for (columnName, value) in row {
//                            print("Plan: \(columnName) = \(value)")
                            if(columnName == "CourseNumber"){
                                courseNum = value as? String ?? ""
                            }else if(columnName == "Year"){
                               year = value as? String ?? ""
                            }else{
                                quarter = value as? String ?? ""
                            }
                        }
                        let key = year + " " + quarter
                        let secNum = self.yqToSecNum[key]
                        let index = self.courseTable[secNum!]?.firstIndex(of: "")
                        self.courseTable[secNum!]![index!] = courseNum
//                        print("added \(courseNum) to section \(secNum) given \(year), \(quarter)")
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
    
    func add(pid: Int, courseNum: String, year: String, quarter: String, changeListener: @escaping (() -> Void)){
        var query = ""
//        query = "EXEC [insertNewPlanContain] @PlanID = \(pid),@CourseNumber = '\(courseNum)',@Year = '\(year)',@Quarter = '\(quarter)'"
        query = "Declare @output int EXEC [insertNewPlanContain] \(pid),'\(courseNum)', '\(year)', '\(quarter)', @output OUTPUT select @output"
        
        print("query: \(query)")
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(query, completion: { (_ results: ([Any]?)) in
            if let r = results as? [[[String:AnyObject]]]{
                for table in r {//results as! [[[String:AnyObject]]]
                    
                    for row in table {
                       
                        for (columnName, value) in row {
                            print("Plan: \(columnName) = \(value)")
                            let v = value as! Int
                            if(v == -1){
                                print("fail to add course")
                            }else{
                                print("successed")
                                changeListener()
                            }
                        }
                        
                    }
                }
            }else{
                print("no return from database")
            }
                
//                changeListener()
                client.disconnect()
            })
        }
    }
    
    func delete(pid: Int, courseNum: String, year: String, quarter: String, changeListener: @escaping (() -> Void)){
        var query = ""
        query = "DECLARE @output int EXEC [deletePlanContain] \(pid),'\(courseNum)','\(year)','\(quarter)', @output OUTPUT select @output AS result"
        print("query: \(query)")
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(query, completion: { (_ results: ([Any]?)) in
            if let r = results as? [[[String:AnyObject]]]{
                for table in r {//results as! [[[String:AnyObject]]]
                    
                    for row in table {
                        
                        for (columnName, value) in row {
                            print("dCourse: \(columnName) = \(value)")
                           let v = value as! Int
                            if(v == 1){
                                print("successfully deleted")
                                changeListener()
                            }else{
                                print("error deleting file")
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
    
    func getCourseDetailFromNum(courseNum: String, changeListener: @escaping (() -> Void)){
        var query = ""
        query = "SELECT c1.CourseNumber, c1.CourseName, c1.CreditHour, c1.Prerequisite, m.Name AS requiredMajor, p.Abbreviation AS providerAbbrev FROM Course c1 JOIN CourseRequiredMajor c2 on c1.CourseNumber = c2.CourseNumber Join Major m on m.MajorID = c2.RequiredMajorID Left JOIN ProvidedBy p on p.CourseNumber = c1.CourseNumber WHERE c1.CourseNumber = '\(courseNum)'"
        print("query: \(query)")
        
        let client = SQLClient.sharedInstance()!
        client.connect("titan.csse.rose-hulman.edu", username: kUserName, password: kPassword, database: kDatabase) { success in
            client.execute(query, completion: { (_ results: ([Any]?)) in
            if let r = results as? [[[String:AnyObject]]]{
                for table in r {//results as! [[[String:AnyObject]]]
                    var cNum: String?
                    var cName: String?
                    var credit: Float?
                    var pre = [String]()
                    var major = [String]()
                    var providedBy = [String]()
                    
                    for row in table {
                        
                        for (columnName, value) in row {
                            print("Course: \(columnName) = \(value)")
                            switch(columnName){
                            case "CourseNumber":
                                cNum = value as? String ?? ""
                            case "CourseName":
                                cName = value as? String ?? ""
                            case "CreditHour":
                                credit = value as? Float ?? 0.0
                            case "Prerequisite":
                                pre.append(value as? String ?? "")
                            case "requiredMajor":
                                major.append(value as? String ?? "")
                            case "providerAbbrev":
                                providedBy.append(value as? String ?? "")
                            default:
                                print("unrecognized col: \(columnName)")
                            }
                        }
                        
                    }
                    pre = Array(Set(pre))
                    major = Array(Set(major))
                    providedBy = Array(Set(providedBy))
                    let cd = CourseDetail(courseNumber: cNum ?? "", courseName: cName ?? "", creditHour: credit ?? 0.0, preCourse: pre, major: major, dep: providedBy)
                    self.selectedCourse = cd
                }
            }else{
                print("no return from database")
            }
                
                changeListener()
                client.disconnect()
            })
        }
    }
    
    
    
}
