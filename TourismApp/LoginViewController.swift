//
//  ViewController.swift
//  TourismApp
//
//  Created by Wanja on 2021-03-31.
//  Copyright © 2021 Wanja. All rights reserved.
//

import UIKit
 
class LoginViewController: UIViewController {

    // Varialbles
    let defaults = UserDefaults.standard
    var users: [User] = [User]()
    var userAtu: String = ""

    // MARK: OUTLETS
    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLogo.image = UIImage(named:"logo")
            
        if defaults.bool(forKey: "remember") && defaults.string(forKey: "user") != nil {
            userAtu = defaults.string(forKey: "user")!
            if defaults.bool(forKey: "remember") {
                goToAttractions()
            }
        }
    }

    func loadUserJSON() {
        if let filepath = Bundle.main.path(forResource: "login", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                users = try! JSONDecoder().decode([User].self, from: jsonData)
            }
            catch {
                print("Cannot load file")
            }
        }
        else {
            print("File not found")
        }
    }
       
    func checkUser() -> Bool {
        loadUserJSON()
        guard let unwrappedEmail = email.text, let unwrappedPassword = password.text else {
                return false
        }
        // Find user
        for user in users {
            if user.email == unwrappedEmail && user.password == unwrappedPassword {
                userAtu = String(unwrappedEmail.components(separatedBy: "@").first!)
                defaults.set(userAtu, forKey: "user")
                return true
            }
        }
        return false
    }

    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Invalid User/Password", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func rememberMe(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "remember")
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if checkUser() {
            goToAttractions()
        } else {
            showAlert()
        }
    }

    func goToAttractions() {
        guard let listAtt = storyboard?.instantiateViewController(identifier: "list") as? AtrractionViewController else {
                print("Cannot find Attraction List!")
                return
        }
        listAtt.user = userAtu
        show(listAtt, sender: self)
    }
} // end class
