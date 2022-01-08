//
//  VaccinationCentersTVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 08/01/22.
//

import UIKit

class VaccinationCentersTVC: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCenterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
