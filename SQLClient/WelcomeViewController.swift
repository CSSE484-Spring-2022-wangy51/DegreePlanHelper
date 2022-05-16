//
//  WelcomeViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/15/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AuthManager.shared.loginObserver = {
//            print("log state changed")
//            self.performSegue(withIdentifier: kShowPlanListSegue, sender: self)
//        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("set closure")
        AuthManager.shared.loginObserver = {
            print("log state changed")
            self.performSegue(withIdentifier: kShowPlanListSegue, sender: self)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
