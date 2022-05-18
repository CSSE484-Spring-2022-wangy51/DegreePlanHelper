//
//  AddCourseViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/18/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController {

    
    @IBOutlet weak var freshmanButton: UIButton!
    @IBOutlet weak var sophomoreButton: UIButton!
    @IBOutlet weak var juniorButton: UIButton!
    @IBOutlet weak var seniorButton: UIButton!
    @IBOutlet weak var SuperSeniorButton: UIButton!
    @IBOutlet weak var fallButton: UIButton!
    @IBOutlet weak var winterButton: UIButton!
    @IBOutlet weak var springButton: UIButton!
    @IBOutlet weak var summerButton: UIButton!
    @IBOutlet weak var courseNumberTextField: UITextField!
    @IBOutlet weak var addCourseButton: UIButton!
    
    var initColor: UIColor?
    var pressedColor: UIColor?
    var year: String?
    var quarter: String?
    var chooseYear: Bool = false
    var chooseQuarter: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initColor = fallButton.backgroundColor
        pressedColor = sophomoreButton.backgroundColor
        sophomoreButton.backgroundColor = initColor
        addCourseButton.isHidden = true
    }
    
    
    @IBAction func pressedFreshman(_ sender: Any) {
        freshmanButton.backgroundColor = pressedColor
        sophomoreButton.backgroundColor = initColor
        juniorButton.backgroundColor = initColor
        seniorButton.backgroundColor = initColor
        SuperSeniorButton.backgroundColor = initColor
        year = "freshman"
        chooseYear = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedSophomore(_ sender: Any) {
        freshmanButton.backgroundColor = initColor
        sophomoreButton.backgroundColor = pressedColor
        juniorButton.backgroundColor = initColor
        seniorButton.backgroundColor = initColor
        SuperSeniorButton.backgroundColor = initColor
        year = "sophomore"
        chooseYear = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedJunior(_ sender: Any) {
        freshmanButton.backgroundColor = initColor
        sophomoreButton.backgroundColor = initColor
        juniorButton.backgroundColor = pressedColor
        seniorButton.backgroundColor = initColor
        SuperSeniorButton.backgroundColor = initColor
        year = "junior"
        chooseYear = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedSenior(_ sender: Any) {
        freshmanButton.backgroundColor = initColor
        sophomoreButton.backgroundColor = initColor
        juniorButton.backgroundColor = initColor
        seniorButton.backgroundColor = pressedColor
        SuperSeniorButton.backgroundColor = initColor
        year = "senior"
        chooseYear = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedSuperSenior(_ sender: Any) {
        freshmanButton.backgroundColor = initColor
        sophomoreButton.backgroundColor = initColor
        juniorButton.backgroundColor = initColor
        seniorButton.backgroundColor = initColor
        SuperSeniorButton.backgroundColor = pressedColor
        year = "super senior"
        chooseYear = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedFall(_ sender: Any) {
        fallButton.backgroundColor = pressedColor
        winterButton.backgroundColor = initColor
        springButton.backgroundColor = initColor
        summerButton.backgroundColor = initColor
        quarter = "fall"
        chooseQuarter = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedWinter(_ sender: Any) {
        fallButton.backgroundColor = initColor
        winterButton.backgroundColor = pressedColor
        springButton.backgroundColor = initColor
        summerButton.backgroundColor = initColor
        quarter = "winter"
        chooseQuarter = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedSpring(_ sender: Any) {
        fallButton.backgroundColor = initColor
        winterButton.backgroundColor = initColor
        springButton.backgroundColor = pressedColor
        summerButton.backgroundColor = initColor
        quarter = "spring"
        chooseQuarter = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedSummer(_ sender: Any) {
        fallButton.backgroundColor = initColor
        winterButton.backgroundColor = initColor
        springButton.backgroundColor = initColor
        summerButton.backgroundColor = pressedColor
        quarter = "summer"
        chooseQuarter = true
        checkShowButtonOrNot()
    }
    
    @IBAction func pressedAddCourse(_ sender: Any) {
    }
    
    func checkShowButtonOrNot(){
        if(chooseYear && chooseQuarter){
            addCourseButton.isHidden = false
        }
    }
    
    @IBAction func changedTextFiled(_ sender: Any) {
        checkShowButtonOrNot()
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
