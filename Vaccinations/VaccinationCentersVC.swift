//
//  VaccinationCentersVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import UIKit
import EzPopup

class VaccinationCentersVC: UIViewController {

    private var webservice :WebServices!
    private var centersListViewModel: CentersListViewModel!
    private var dataSource :TableViewDataSource<VaccinationCentersTVC, CenterViewModel>!
    
    var districtId: Int?
    var pincode: String?
    var date: String?
    
    @IBOutlet weak var tblCenters: UITableView!
    @IBOutlet weak var lblBlankMessage: UILabel!
    @IBOutlet weak var lblVaccineName: UILabel!
    var forPaid = true {
        didSet{
            if let districtId = districtId, let date = date {
                setViewOnDistrict(districtId: districtId, date: date, forPaid: forPaid)
            }
            
            if let pincode = pincode, let date = date {
                setViewOnPincode(pincode: pincode, date: date, forPaid: forPaid)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let districtId = districtId, let date = date {
            setViewOnDistrict(districtId: districtId, date: date, forPaid: self.forPaid)
        }
        
        if let pincode = pincode, let date = date {
            setViewOnPincode(pincode: pincode, date: date, forPaid: self.forPaid)
        }
        
    }
    
    private func setViewOnPincode(pincode: String, date: String , forPaid: Bool) {
        self.webservice = WebServices()
        self.centersListViewModel = CentersListViewModel(webservice: webservice, pincode: pincode, date: date, forPaid: forPaid)
        self.centersListViewModel.bindToCenterViewModels = {
            self.updateDataSource()
        }
    }
    
    private func setViewOnDistrict(districtId: Int, date: String, forPaid: Bool) {
        self.webservice = WebServices()
        self.centersListViewModel = CentersListViewModel(webservice: webservice, districtId: districtId, date: date, forPaid: forPaid)
        self.centersListViewModel.bindToCenterViewModels = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        if forPaid {
            lblVaccineName.text = self.centersListViewModel.getAllVaccines().map({ "\($0.vaccineName) - \($0.vaccineFees)₹" }).joined(separator: ", ")
        } else {
            lblVaccineName.text = self.centersListViewModel.getAllVaccines().map({ "\($0.vaccineName)" }).joined(separator: ", ")
        }
        if !self.centersListViewModel.centerViewModeles.isEmpty {
            lblBlankMessage.isHidden = true
            tblCenters.isHidden = false
            self.dataSource = TableViewDataSource(cellIdentifier: Cells.centerCell, items: self.centersListViewModel.centerViewModeles) { cell, vm, index in
                
                cell.delegate = self
                cell.lblDate.text = vm.date
                cell.lblCenterName.text = vm.name
                cell.btnShowSlots.tag = index
                
            }
            
            self.tblCenters.dataSource = self.dataSource
            self.tblCenters.reloadData()
        } else {
            lblBlankMessage.isHidden = false
            tblCenters.isHidden = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onPaymentTypeChanged(_ sender: UISegmentedControl) {
        self.forPaid = sender.selectedSegmentIndex == 0
    }
}

extension VaccinationCentersVC: ButtonTappedActions {
    func didTapOnSlots(_ sender: UIButton) {
        print("\(sender.tag)")
        let slotsAlertVC = SlotsTableVC.instantiate()
        slotsAlertVC?.slots = self.centersListViewModel.center(at: sender.tag).slots ?? [String]()
        let popupVC = PopupViewController(contentController: slotsAlertVC!, popupWidth: 200, popupHeight: 200)
        popupVC.cornerRadius = 5
        present(popupVC, animated: true, completion: nil)
    }
    
    
}
