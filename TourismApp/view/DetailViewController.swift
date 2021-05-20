//
//  DetailViewController.swift
//  TourismApp
//
//  Created by Wanja on 2021-04-02.
//  Copyright © 2021 Wanja. All rights reserved.
//

import UIKit
import Cosmos   // Rating
import WebKit   // Website

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    // Variables
    let defaults = UserDefaults.standard
    var userPreferences: [Preferences] = []
    var user: String?
    var attractionDetail: Attraction?
    var webView: WKWebView!
    
    
    // MARK: OUTLETS
    @IBOutlet weak var nameAttraction: UILabel!
    @IBOutlet weak var attractionImage1: UIImageView!
    @IBOutlet weak var attractionImage2: UIImageView!
    @IBOutlet weak var atrractionDescription: UILabel!
    @IBOutlet weak var attractionAddress: UILabel!
    @IBOutlet weak var attractionPrice: UILabel!
    @IBOutlet weak var attractionPhone: UIButton!
    @IBOutlet weak var attractionRating: CosmosView!
    @IBOutlet weak var attractionWebsite: UIButton!
    @IBOutlet weak var ratingYourAttraction: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
         nameAttraction.text = "\(attractionDetail!.name)"
         attractionImage1.image = UIImage(named:"\(attractionDetail!.image1)")
         attractionImage2.image = UIImage(named:"\(attractionDetail!.image2)")
         atrractionDescription.text = "\(attractionDetail!.description)"
         attractionAddress.text =  "\(attractionDetail!.address)"
         attractionWebsite.setTitle(attractionDetail!.website, for: .normal)
         let price = Int(attractionDetail!.price)
         if price == 0 {
            attractionPrice.text = "FREE"
            attractionPrice.textColor = UIColor.red
         } else {
             attractionPrice.text = "$\(attractionDetail!.price)"
         }
         attractionPhone.setTitle(attractionDetail!.phone, for: .normal)
        
         retrieveRating()
 
         ratingYourAttraction.text =  "Rating  - \(attractionDetail!.name)"
        
        // update rating
        attractionRating.didFinishTouchingCosmos = { rating in
            print("saveUserRating() \(self.attractionDetail!.id) \(rating)" )

            //self.userPreferences[self.attractionDetail!.id].rating = rating
            let fileName: String = self.user! + "_prefs.json"
            do {
                let fileURL = try FileManager.default
                    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent(fileName)
                try JSONEncoder().encode(self.userPreferences)
                    .write(to: fileURL)
                } catch {
                     print(error)
                }
        }
     } // end viewDidLoad()
    
    func  retrieveRating() {
      let fileName: String = user! + "_prefs.json"

      if let filepath = Bundle.main.path(forResource: fileName, ofType: "json") {
            print(filepath)
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                userPreferences = try! JSONDecoder().decode([Preferences].self, from: jsonData)
            }
            catch {
                print("Cannot load file")
            }
        }
        else {
           print("Cannot find")
        }
    }

    // PHONE
    @IBAction func phoneCall(_ sender: UIButton) {
        print("DIALING - Phone Call \(attractionDetail!.phone)")
        //WOM - ERROR:  This app is not allowed to query for scheme tel
         if let url = URL(string: "tel:\(attractionDetail!.phone)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
//       if let phoneCallURL = URL(string: "tel:\(attractionDetail!.phone)") {
//          let application:UIApplication = UIApplication.shared
//          if (application.canOpenURL(phoneCallURL)) {
//              application.open(phoneCallURL, options: [:], completionHandler: nil)
//          }
//        }
        
    } // end  phoneCall

    //  WEBSITE
    @IBAction func websiteAttraction(_ sender: UIButton) {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: "\(attractionDetail!.website)")!
        //let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
             
    }  // end websiteAttraction

    @IBAction func logoutPressed(_ sender: UIButton) {
        guard let login = storyboard?.instantiateViewController(identifier: "login") as? LoginViewController else {
                print("Cannot find Login!")
                return
        }
        UserDefaults.standard.removeObject(forKey: "remember")
        UserDefaults.standard.removeObject(forKey: "user")
        present(login, animated: false)
        
    } // end logout
    
}  // end class
