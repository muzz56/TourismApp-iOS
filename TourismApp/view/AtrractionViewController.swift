//
//  AtrractionViewController.swift
//  TourismApp
//
//  Created by Letícia Lima on 2021-04-02.
//  Copyright © 2021 Wanja. All rights reserved.
//

import UIKit

class AtrractionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AttractionCellDelegate {
    
    // MARK: OUTLET
    @IBOutlet weak var attractionsTableView: UITableView!
  

    // MARK: Datasource - List of Attractions
    var listAttractions: [Attraction] = [Attraction]()
    
    // Varialbles
    let defaults = UserDefaults.standard
    var user: String?
    var userPreferences: [Preferences] = []
    var indexPathForCell: IndexPath?
    var rowSelected: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.attractionsTableView.dataSource = self
        self.attractionsTableView.delegate = self
        attractionsTableView.rowHeight = 170
        
        loadAttractionsJSON()
        if !retrieveWishlist() {
            createPreferences()
        }
    }
    
    func loadAttractionsJSON() {
        if let filepath = Bundle.main.path(forResource: "attractions", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                listAttractions = try! JSONDecoder().decode([Attraction].self, from: jsonData)
            }
            catch {
                print("Cannot load file")
            }
        }
        else {
            print("File not found")
        }
    }
    
    func retrieveWishlist() -> Bool {
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
            return true
        } catch {
            return false
        }
    }
    
    func createPreferences() {
        let fileName: String = user! + "_prefs.json"
        userPreferences.append(Preferences(attraction: 0, wishList: false, rating: 0.0))
        userPreferences.append(Preferences(attraction: 1, wishList: false, rating: 0.0))
        userPreferences.append(Preferences(attraction: 2, wishList: false, rating: 0.0))
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(userPreferences)
            
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAttractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = attractionsTableView.dequeueReusableCell(withIdentifier: "attraction") as? AttractionTableViewCell
        
        if (cell == nil) {
            cell = AttractionTableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: "attraction")
        }
            
        // setup the AttractionCell delegate
        cell?.delegate = self
        cell?.indexPath = indexPath
        
        indexPathForCell?.item = indexPath.row
        cell?.mainImage.image = UIImage(named: listAttractions[indexPath.row].mainImage)
        cell?.nameLabel.text = listAttractions[indexPath.row].name
        cell?.addressLabel.text = listAttractions[indexPath.row].address
        cell?.wishList.isOn = userPreferences[indexPath.row].wishList
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSelected = indexPath.row;
        guard let attr = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController else {
              print("Cannot find the second screen!")
              return
        }
        attr.user = user
        attr.attractionDetail = listAttractions[rowSelected]
        show(attr, sender: self)
    }

    func wishAttractionPressed(at indexPath: IndexPath, wish: UISwitch ) {
        userPreferences[indexPath.row].wishList = wish.isOn
        updatePreferences()
    }
    
    func updatePreferences() {
        let fileName: String = user! + "_prefs.json"
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(userPreferences)
            
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
    @IBAction func logoutPressed(_ sender: UIButton) {
        guard let login = storyboard?.instantiateViewController(identifier: "login") as? LoginViewController else {
                print("Cannot find Login!")
                return
        }
        UserDefaults.standard.removeObject(forKey: "remember")
        UserDefaults.standard.removeObject(forKey: "user")
        present(login, animated: false)
    }
    

} // end class
