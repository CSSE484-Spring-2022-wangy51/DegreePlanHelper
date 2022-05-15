//
//  RegisterViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/14/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var professorButton: UIButton!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTextField: UITextField!
    
    var isProfessor = false
    var color: UIColor?
    var role: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.rankLabel.isHidden = true
        self.rankTextField.isHidden = true
        self.color = self.professorButton.backgroundColor
    }
    
    @IBAction func pressedRegister(_ sender: Any) {
        AuthManager.shared.registerNewUser(role: role!, firstName: FirstNameTextField.text!, lastName: lastNameTextField.text!, userName: UsernameTextField.text!, password: passwordTextField.text!, rank: rankTextField.text ?? "")
    }
    
    @IBAction func pressedStudent(_ sender: Any) {
        self.isProfessor = false
        self.studentButton.backgroundColor = UIColor.purple
        self.professorButton.backgroundColor = color
        self.rankLabel.isHidden = true
        self.rankTextField.isHidden = true
        self.role = "s"
    }
    
    @IBAction func pressedProfessor(_ sender: Any) {
        self.isProfessor = true
        self.professorButton.backgroundColor = UIColor.purple
        self.studentButton.backgroundColor = color
        self.rankLabel.isHidden = false
        self.rankTextField.isHidden = false
        self.role = "p"
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
