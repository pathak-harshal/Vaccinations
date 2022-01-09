//
//  CentersListViewModel.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import Foundation
class CentersListViewModel: NSObject {
    private var webservice: WebServices
    private var pincode: String?
    private var districtId: Int?
    private var date: String
    @objc dynamic private(set) var centerViewModeles: [CenterViewModel] = [CenterViewModel]()
    var bindToCenterViewModels :(() -> ()) = {  }
    private var token :NSKeyValueObservation?
    private var forPaid: Bool
    
    init(webservice: WebServices, pincode: String, date: String, forPaid: Bool) {
        
        self.webservice = webservice
        self.pincode = pincode
        self.date = date
        self.forPaid = forPaid
        super.init()
        token = self.observe(\.centerViewModeles) { _,_ in
            self.bindToCenterViewModels()
        }
        // call populate states
        populateAllCentersByPincode(forPaid: forPaid)
    }
    
    init(webservice: WebServices, districtId: Int, date: String, forPaid: Bool) {
        
        self.webservice = webservice
        self.districtId = districtId
        self.date = date
        self.forPaid = forPaid
        super.init()
        token = self.observe(\.centerViewModeles) { _,_ in
            self.bindToCenterViewModels()
        }
        populateAllCentersByDistrict(forPaid: forPaid)
    }
    
    func invalidateObservers() {
        self.token?.invalidate()
    }
    
    func populateAllCentersByPincode(forPaid: Bool) {
        if let strongPincode = self.pincode {
            webservice.loadAllCentersByPincode(pincode: strongPincode, date: self.date) { sessions in
                if let allSessions = sessions {
                    if forPaid {
                        let allCenters = allSessions.compactMap(CenterViewModel.init).filter({ $0.fee_type?.uppercased() == "PAID"})
                        print("allCenters count \(allCenters.count)")
                        var uniqueCenters = [CenterViewModel]()
                        for center in allCenters {
                            let firstIndex = uniqueCenters.firstIndex(where: { $0.center_id == center.center_id })
                            if firstIndex == nil {
                                uniqueCenters.append(center)
                            }
                        }
                        self.centerViewModeles = uniqueCenters
                        print("uniqueCenters count \(uniqueCenters.count)")
                    } else {
                        let allCenters = allSessions.compactMap(CenterViewModel.init).filter({ $0.fee_type?.uppercased() == "FREE"})
                        print("allCenters count \(allCenters.count)")
                        var uniqueCenters = [CenterViewModel]()
                        for center in allCenters {
                            let firstIndex = uniqueCenters.firstIndex(where: { $0.center_id == center.center_id })
                            if firstIndex == nil {
                                uniqueCenters.append(center)
                            }
                        }
                        self.centerViewModeles = uniqueCenters
                        print("uniqueCenters count \(uniqueCenters.count)")
                    }
                }
            }
        }
    }
    
    func populateAllCentersByDistrict(forPaid: Bool) {
        if let strongDistrictId = self.districtId {
            webservice.loadAllCentersByDistrict(districtId: strongDistrictId, date: self.date) { sessions in
                if let allSessions = sessions {
                    if forPaid {
                        let allCenters = allSessions.compactMap(CenterViewModel.init).filter({ $0.fee_type?.uppercased() == "PAID"})
                        print("allCenters count \(allCenters.count)")
                        var uniqueCenters = [CenterViewModel]()
                        for center in allCenters {
                            let firstIndex = uniqueCenters.firstIndex(where: { $0.center_id == center.center_id })
                            if firstIndex == nil {
                                uniqueCenters.append(center)
                            }
                        }
                        self.centerViewModeles = uniqueCenters
                        print("uniqueCenters count \(uniqueCenters.count)")
                    } else {
                        let allCenters = allSessions.compactMap(CenterViewModel.init).filter({ $0.fee_type?.uppercased() == "FREE"})
                        print("allCenters count \(allCenters.count)")
                        var uniqueCenters = [CenterViewModel]()
                        for center in allCenters {
                            let firstIndex = uniqueCenters.firstIndex(where: { $0.center_id == center.center_id })
                            if firstIndex == nil {
                                uniqueCenters.append(center)
                            }
                        }
                        self.centerViewModeles = uniqueCenters
                        print("uniqueCenters count \(uniqueCenters.count)")
                    }
                }
            }
        }
    }
    
    func center(at index:Int) -> CenterViewModel {
        return self.centerViewModeles[index]
    }
    
    func getAllVaccines() -> [Vaccine] {
        var vaccines = [Vaccine]()
        
        for model in self.centerViewModeles {
            let firstIndex = vaccines.firstIndex(where: { $0.vaccineName == model.vaccine })
            if firstIndex == nil {
                vaccines.append(Vaccine(vaccineName: model.vaccine!, vaccineFees: model.fee!))
            }
        }
        
        return vaccines
    }
}

class CenterViewModel: NSObject {
    let center_id : Int?
    let name : String?
    let address : String?
    let state_name : String?
    let district_name : String?
    let block_name : String?
    let pincode : Int?
    let from : String?
    let to : String?
    let lat : Int?
    let long : Int?
    let fee_type : String?
    let session_id : String?
    let date : String?
    let available_capacity : Int?
    let available_capacity_dose1 : Int?
    let available_capacity_dose2 : Int?
    let fee : String?
    let allow_all_age : Bool?
    let min_age_limit : Int?
    let max_age_limit : Int?
    let vaccine : String?
    let slots : [String]?
    
    init(center_id : Int?,name : String?, address : String?, state_name : String?, district_name : String?, block_name : String?, pincode : Int?, from : String?, to : String?, lat : Int?, long : Int?, fee_type : String?, session_id : String?, date : String?, available_capacity : Int?, available_capacity_dose1 : Int?, available_capacity_dose2 : Int?, fee : String?, allow_all_age : Bool?, min_age_limit : Int?, max_age_limit : Int?, vaccine : String?, slots : [String]?) {
        self.center_id = center_id
        self.name = name
        self.address = address
        self.state_name = state_name
        self.district_name = district_name
        self.block_name = block_name
        self.pincode = pincode
        self.from = from
        self.to = to
        self.lat = lat
        self.long = long
        self.fee_type = fee_type
        self.session_id = session_id
        self.date = date
        self.available_capacity = available_capacity
        self.available_capacity_dose1 = available_capacity_dose1
        self.available_capacity_dose2 = available_capacity_dose2
        self.fee = fee
        self.allow_all_age = allow_all_age
        self.min_age_limit = min_age_limit
        self.max_age_limit = max_age_limit
        self.vaccine = vaccine
        self.slots = slots
    }
    
    init(center: Sessions) {
        self.center_id = center.center_id
        self.name = center.name
        self.address = center.address
        self.state_name = center.state_name
        self.district_name = center.district_name
        self.block_name = center.block_name
        self.pincode = center.pincode
        self.from = center.from
        self.to = center.to
        self.lat = center.lat
        self.long = center.long
        self.fee_type = center.fee_type
        self.session_id = center.session_id
        self.date = center.date
        self.available_capacity = center.available_capacity
        self.available_capacity_dose1 = center.available_capacity_dose1
        self.available_capacity_dose2 = center.available_capacity_dose2
        self.fee = center.fee
        self.allow_all_age = center.allow_all_age
        self.min_age_limit = center.min_age_limit
        self.max_age_limit = center.max_age_limit
        self.vaccine = center.vaccine
        self.slots = center.slots
    }
}
