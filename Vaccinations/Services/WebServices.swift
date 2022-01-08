//
//  WebServices.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 02/01/22.
//

import Foundation

typealias JSONDictionary = [String:Any]

class WebServices {
    
    func loadAllStates(completion :@escaping ([State]?) -> ()) {
        guard let url = URL(string: "https://cdn-api.co-vin.in/api/v2/admin/location/states") else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(nil)
                    return
                }
                let result = json["states"] as! [JSONDictionary]
                
                let states = result.compactMap(State.init)
                
                DispatchQueue.main.async {
                    completion(states)
                }
            }
        }.resume()
    }
    
    func loadAllDistricts(stateId: Int, completion :@escaping ([District]?) -> ()) {
        guard let url = URL(string: "https://cdn-api.co-vin.in/api/v2/admin/location/districts/\(stateId)") else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(nil)
                    return
                }
                let result = json["districts"] as! [JSONDictionary]
                
                let districts = result.compactMap(District.init)
                
                DispatchQueue.main.async {
                    completion(districts)
                }
            }
        }.resume()
    }
    
    func loadAllCentersByPincode(pincode: String, date: String, completion :@escaping ([Sessions]?) -> ()) {
        guard let url = URL(string: "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=\(pincode)&date=\(date)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("hi_IN", forHTTPHeaderField: "Accept-Language")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                guard let responseModel = try? jsonDecoder.decode(VaccinationCenterRespons.self, from: data) else {
                    completion(nil)
                    return
                }
                
                guard let centers = responseModel.sessions else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    completion(centers)
                }
            }
        }.resume()
    }
    
    func loadAllCentersByDistrict(districtId: Int, date: String, completion :@escaping ([Sessions]?) -> ()) {
        guard let url = URL(string: "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=\(districtId)&date=\(date)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("hi_IN", forHTTPHeaderField: "Accept-Language")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                guard let responseModel = try? jsonDecoder.decode(VaccinationCenterRespons.self, from: data) else {
                    completion(nil)
                    return
                }
                
                guard let centers = responseModel.sessions else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    completion(centers)
                }
            }
        }.resume()
    }
}
