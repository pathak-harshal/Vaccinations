//
//  State.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import Foundation

class State {
    var stateId: Int!
    var stateName: String!
    
    init?(dictionary: JSONDictionary) {
        guard let stateId = dictionary["state_id"] as? Int, let stateName = dictionary["state_name"] as? String else {
            return nil
        }
        self.stateId = stateId
        self.stateName = stateName
    }
    
    init(viewModel: StateViewModel) {
        self.stateId = viewModel.stateId
        self.stateName = viewModel.stateName
    }
}
