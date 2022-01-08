/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Sessions : Codable {
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

	enum CodingKeys: String, CodingKey {

		case center_id = "center_id"
		case name = "name"
		case address = "address"
		case state_name = "state_name"
		case district_name = "district_name"
		case block_name = "block_name"
		case pincode = "pincode"
		case from = "from"
		case to = "to"
		case lat = "lat"
		case long = "long"
		case fee_type = "fee_type"
		case session_id = "session_id"
		case date = "date"
		case available_capacity = "available_capacity"
		case available_capacity_dose1 = "available_capacity_dose1"
		case available_capacity_dose2 = "available_capacity_dose2"
		case fee = "fee"
		case allow_all_age = "allow_all_age"
		case min_age_limit = "min_age_limit"
        case max_age_limit = "max_age_limit"
		case vaccine = "vaccine"
		case slots = "slots"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		center_id = try values.decodeIfPresent(Int.self, forKey: .center_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
		district_name = try values.decodeIfPresent(String.self, forKey: .district_name)
		block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
		pincode = try values.decodeIfPresent(Int.self, forKey: .pincode)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		lat = try values.decodeIfPresent(Int.self, forKey: .lat)
		long = try values.decodeIfPresent(Int.self, forKey: .long)
		fee_type = try values.decodeIfPresent(String.self, forKey: .fee_type)
		session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		available_capacity = try values.decodeIfPresent(Int.self, forKey: .available_capacity)
		available_capacity_dose1 = try values.decodeIfPresent(Int.self, forKey: .available_capacity_dose1)
		available_capacity_dose2 = try values.decodeIfPresent(Int.self, forKey: .available_capacity_dose2)
		fee = try values.decodeIfPresent(String.self, forKey: .fee)
		allow_all_age = try values.decodeIfPresent(Bool.self, forKey: .allow_all_age)
		min_age_limit = try values.decodeIfPresent(Int.self, forKey: .min_age_limit)
        max_age_limit = try values.decodeIfPresent(Int.self, forKey: .max_age_limit)
		vaccine = try values.decodeIfPresent(String.self, forKey: .vaccine)
		slots = try values.decodeIfPresent([String].self, forKey: .slots)
	}

    init(viewModel: CenterViewModel) {
        self.center_id = viewModel.center_id
        self.name = viewModel.name
        self.address = viewModel.address
        self.state_name = viewModel.state_name
        self.district_name = viewModel.district_name
        self.block_name = viewModel.block_name
        self.pincode = viewModel.pincode
        self.from = viewModel.from
        self.to = viewModel.to
        self.lat = viewModel.lat
        self.long = viewModel.long
        self.fee_type = viewModel.fee_type
        self.session_id = viewModel.session_id
        self.date = viewModel.date
        self.available_capacity = viewModel.available_capacity
        self.available_capacity_dose1 = viewModel.available_capacity_dose1
        self.available_capacity_dose2 = viewModel.available_capacity_dose2
        self.fee = viewModel.fee
        self.allow_all_age = viewModel.allow_all_age
        self.min_age_limit = viewModel.min_age_limit
        self.max_age_limit = viewModel.max_age_limit
        self.vaccine = viewModel.vaccine
        self.slots = viewModel.slots
    }
}
