//
//  StatesListViewModel.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import Foundation

class StatesListViewModel: NSObject {
    private var webservice: WebServices
    @objc dynamic private(set) var stateViewModels: [StateViewModel] = [StateViewModel]()
    var bindToStateViewModels :(() -> ()) = {  }
    private var token :NSKeyValueObservation?
    
    init(webservice: WebServices) {
        
        self.webservice = webservice
        super.init()
        token = self.observe(\.stateViewModels) { _,_ in
            self.bindToStateViewModels()
        }
        // call populate states
        populateAllStates()
    }
    
    func invalidateObservers() {
        self.token?.invalidate()
    }
    
    func populateAllStates() {
        webservice.loadAllStates { states in
            if let allStates = states {
                self.stateViewModels = allStates.compactMap(StateViewModel.init)
            }
        }
    }
    
    func state(at index:Int) -> StateViewModel {
        return self.stateViewModels[index]
    }
}

class StateViewModel: NSObject {
    var stateId: Int
    var stateName: String
    
    init(stateId: Int, stateName: String) {
        self.stateId = stateId
        self.stateName = stateName
    }
    
    init(state: State) {
        self.stateId = state.stateId
        self.stateName = state.stateName
    }
}
