//
//  LoginViewController.swift
//  TourismApp
//
//  Created by Letícia Lima on 2021-04-02.
//  Copyright © 2021 Wanja. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let defauts = UserDefaults.standard
    let user: User?

    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
