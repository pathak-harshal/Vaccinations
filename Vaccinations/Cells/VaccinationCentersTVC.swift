//
//  VaccinationCentersTVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 08/01/22.
//

import UIKit

protocol ButtonTappedActions {
    func didTapOnSlots(_ sender: UIButton)
}

class VaccinationCentersTVC: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCenterName: UILabel!
    @IBOutlet weak var btnShowSlots: UIButton!
    
    var delegate: ButtonTappedActions?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionForSlots(_ sender: UIButton) {
        delegate?.didTapOnSlots(sender)
    }

}
