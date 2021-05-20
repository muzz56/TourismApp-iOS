//
//  ViewController.swift
//  TourismApp
//
//  Created by Wanja on 2021-04-02.
//  Copyright © 2021 Wanja. All rights reserved.
//
// **************  IMPLEMENT ******************

// Class and structs
// class Attraction: Codable  - Explain Codable
// struct User: Codable       @TODO: rememberMe move to Userdefault not in struct

// Enum, Protocol and Extension

// JSON
// User Login: login.json
// Attractions: attractions.json

// USER DEFAULTS
// user: rememberMe  (read before login if exists go to Attraction List)
// user-attraction: wishlist (update in Attraction List before load)
// user-attraction: rating  -  JSON or UserDefault? (update in Attraction Detail before load)

// LOGIN
//  guard let
//  Invalid User/password
//  User does not exist
//  Remember Me - User defaults

// ATTRACTION LIST
//  wishlist - User defaults

// ATTRACTION DETAIL
//  Phone - does not work in Simulator
//  Website - delegate - WEBKit
//  Rating - User defaults or JSON ?

//  LOGOUT
//  Erase Remember me - delete User defaults

// Tab Bars for Logout ?

// EXTENSION
/* extension String
{
    func webString() -> String {
        return self.lowercased()
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
            .replacingOccurrences(of: "www.", with: "")
    }
}
*/

// ENUM
/* ????
*/

/*
Model of User defaults:
https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults
    User + rememberMe
    User + array [(ind attraction 0..1) + wishlist  (Shitch)]
        ind 0:  true/false ...
    User +  array [(ind attraction 0..1) + rating (stars)]
    
    let arrWishlist[] = [false, false, false]
    defaults.set(arrWishlist,  forKey: “wishlist”)
    let wishlist = defaults.object(forKey: “wishlist”) as? [Bool] ?? [Bool]()

    let arrRating[] = [0.0, 0.0, 0.0]  or nil, nil, nil ?
    defaults.set( arrRating  forKey: “rating”)
     let rating = defaults.object(forKey: “rating”) as? [Double] ?? [Double]()

*/
/*
LOGOUT
func logout() {
  UserDefaults.standard.set(false, forKey: “isLoggedIn”)
  let logginController = LoginController()
  present(logginController,animated: true, completion: nil)
}
*/

/*
EXTENSION UserDefaults

*/



import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
}
