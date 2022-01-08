//
//  Districts.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import Foundation
class District {
    let districtId: Int!
    let districtName: String!
    
    init?(dictionary: JSONDictionary) {
        guard let districtId = dictionary["district_id"] as? Int, let districtName = dictionary["district_name"] as? String else {
            return nil
        }
        self.districtId = districtId
        self.districtName = districtName
    }
    
    init(viewModel: DistrictViewModel) {
        self.districtId = viewModel.districtId
        self.districtName = viewModel.districtName
    }
}
