//
//  TableViewCell.swift
//  Countries
//
//  Created by Omar Salem on 19/03/2024.
//

import UIKit

class CustomCountryCell: UITableViewCell {

    @IBOutlet weak var countryFlagLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
