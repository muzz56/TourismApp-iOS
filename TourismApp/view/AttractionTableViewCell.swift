//
//  AttractionTableViewCell.swift
//  TourismApp
//
//  Created by Wanja on 2021-03-31.
//  Copyright © 2021 Wanja. All rights reserved.
//

import UIKit
// TABLEVIEW CHECKLIST:
// Main.storyboard:
// - add tableview
// - add table cell to tableview
//      - give table cell an IDENTIFIER (example: "myCell")

// ViewController.swift:
// - add outlet for tableview
// - add delegate and datasource protocols
//      - attach outlet to protocols in viewDidLoad
// - add array of data (datasource)
// - add mandatory functions

class AttractionTableViewCell: UITableViewCell   {
    
     //  MARK: OUTLETS
     @IBOutlet weak var attractionImage: UIImageView!
     @IBOutlet weak var attractionName: UILabel!
     @IBOutlet weak var attractionWishList: UISwitch!
    
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
    }

}
