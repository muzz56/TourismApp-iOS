//
//  AttractionTableViewCell.swift
//  TourismApp
//
//  Created by Wanja on 2021-04-02.
//  Copyright © 2021 Wanja. All rights reserved.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    // MARK: OUTLETS
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var wishList: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Mandatory delegate variables
    var delegate: AttractionCellDelegate?
    
    // Custom properties
    var indexPath: IndexPath!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func attractionWishPressed(_ sender: UISwitch) {
        self.delegate?.wishAttractionPressed(at: indexPath)
    }
    
} // end TableViewCell

//  *** PROTOCOL
protocol AttractionCellDelegate {
    
    func wishAttractionPressed(at indexPath: IndexPath)
    
} // end Protocol

