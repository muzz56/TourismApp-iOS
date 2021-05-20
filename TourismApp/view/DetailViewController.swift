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
         attractionRating.rating = userPreferences[attractionDetail!.id].rating
        
        // update rating
        attractionRating.didFinishTouchingCosmos = { rating in
            self.userPreferences[self.attractionDetail!.id].rating = rating
            let fileName: String = self.user! + "_prefs.json"
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let jsonData = try encoder.encode(self.userPreferences)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    let finalPath = paths[0]
                    let filename = finalPath.appendingPathComponent(fileName)
                    try jsonString.write(to: filename, atomically:true, encoding: String.Encoding.utf8)
                }
                else {
                    print("Error when converting data to a string")
                }
            }
            catch {
                print("Error converting or saving to JSON")
                print(error.localizedDescription)
            }
        }
     } // end viewDidLoad()
    
    func  retrieveRating() {
         let fileName: String = user! + "_prefs.json"
         do {
               let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
               let finalPath = paths[0]
               let filename = finalPath.appendingPathComponent(fileName)
               let contents = try String(contentsOf: filename, encoding: .utf8)
               // decode the contents
               let jsonData = contents.data(using: .utf8)!
               // Store contents of json in ARRAY
               userPreferences = try! JSONDecoder().decode([Preferences].self, from: jsonData)
           } catch {
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
