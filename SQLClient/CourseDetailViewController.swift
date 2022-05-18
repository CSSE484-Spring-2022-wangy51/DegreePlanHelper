//
//  CourseDetailViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 4/29/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {

    
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var creditHourLabel: UILabel!
    @IBOutlet weak var prerequisitLabel: UILabel!
    @IBOutlet weak var offeredByDepartmentLabel: UILabel!
    @IBOutlet weak var requiredByMajorLabel: UILabel!
    
    var courseNum: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("get courseNum: \(courseNum)")
        PlanDetailDocumentManager.shared.getCourseDetailFromNum(courseNum: courseNum!) {
            self.updateView()
        }
        // Do any additional setup after loading the view.
    }
    

    func updateView(){
        let c = PlanDetailDocumentManager.shared.selectedCourse
        self.courseNameLabel.text = c.courseName
        self.courseNumberLabel.text = c.courseNumber
        self.creditHourLabel.text = String(c.creditHour)
        self.prerequisitLabel.text = c.preCourse.joined(separator: ", ")
        self.offeredByDepartmentLabel.text = c.dep.joined(separator: ", ")
        self.requiredByMajorLabel.text = c.major.joined(separator: ", ")
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
