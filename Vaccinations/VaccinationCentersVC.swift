//
//  VaccinationCentersVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import UIKit

class VaccinationCentersVC: UIViewController {

    private var webservice :WebServices!
    private var centersListViewModel: CentersListViewModel!
    private var dataSource :TableViewDataSource<VaccinationCentersTVC, CenterViewModel>!
    
    var districtId: Int?
    var pincode: String?
    var date: String?
    
    @IBOutlet weak var tblCenters: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let districtId = districtId, let date = date {
            setViewOnDistrict(districtId: districtId, date: date)
        }
        
        if let pincode = pincode, let date = date {
            setViewOnPincode(pincode: pincode, date: date)
        }
        
    }
    
    private func setViewOnPincode(pincode: String, date: String) {
        self.webservice = WebServices()
        self.centersListViewModel = CentersListViewModel(webservice: webservice, pincode: pincode, date: date)
        self.centersListViewModel.bindToCenterViewModels = {
            self.updateDataSource()
        }
    }
    
    private func setViewOnDistrict(districtId: Int, date: String) {
        self.webservice = WebServices()
        self.centersListViewModel = CentersListViewModel(webservice: webservice, districtId: districtId, date: date)
        self.centersListViewModel.bindToCenterViewModels = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        
        self.dataSource = TableViewDataSource(cellIdentifier: Cells.centerCell, items: self.centersListViewModel.centerViewModeles) { cell, vm in
            
            cell.lblDate.text = vm.date
            cell.lblCenterName.text = vm.name
            
        }
        
        self.tblCenters.dataSource = self.dataSource
        self.tblCenters.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
