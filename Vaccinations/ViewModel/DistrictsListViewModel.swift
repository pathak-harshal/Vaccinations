//
//  DistrictsListViewModel.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import Foundation
class DistrictsListViewModel: NSObject {
    private var webservice: WebServices
    private var stateId: Int
    @objc dynamic private(set) var districtViewModels: [DistrictViewModel] = [DistrictViewModel]()
    var bindToDistrictViewModels :(() -> ()) = {  }
    private var token :NSKeyValueObservation?
    
    init(webservice: WebServices, stateId: Int) {
        
        self.webservice = webservice
        self.stateId = stateId
        super.init()
        token = self.observe(\.districtViewModels) { _,_ in
            self.bindToDistrictViewModels()
        }
        // call populate states
        populateAllDistricts()
    }
    
    func invalidateObservers() {
        self.token?.invalidate()
    }
    
    func populateAllDistricts() {
        webservice.loadAllDistricts(stateId: self.stateId) { districts in
            if let allDistricts = districts {
                self.districtViewModels = allDistricts.compactMap(DistrictViewModel.init)
            }
        }
    }
    
    func district(at index:Int) -> DistrictViewModel {
        return self.districtViewModels[index]
    }
}

class DistrictViewModel: NSObject {
    let districtId: Int
    let districtName: String
    
    init(districtId: Int, districtName: String) {
        self.districtId = districtId
        self.districtName = districtName
    }
    
    init(district: District) {
        self.districtId = district.districtId
        self.districtName = district.districtName
    }
}
