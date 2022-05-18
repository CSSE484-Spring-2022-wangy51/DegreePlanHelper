//
//  CourseDetail.swift
//  SQLClient
//
//  Created by Helen Wang on 5/18/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation

class CourseDetail{
    var courseNumber: String
    var courseName: String
    var creditHour: Float
    var preCourse : [String]
    var major : [String]
    var dep : [String]
    
    init(courseNumber: String, courseName: String, creditHour: Float, preCourse: [String]?, major: [String], dep: [String]){
        self.courseNumber = courseNumber
        self.courseName = courseName
        self.creditHour = creditHour
        self.preCourse = preCourse ?? [String]()
        self.major = major
        self.dep = dep
    }
}
