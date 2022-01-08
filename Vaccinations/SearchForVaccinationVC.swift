//
//  SearchForVaccinationVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 04/07/21.
//

import UIKit

class SearchForVaccinationVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewSearchWithPinCode: UIView!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtDateForVaccination: UITextField!
    
    @IBOutlet weak var viewSearchWithDistrict: UIView!
    @IBOutlet weak var txtStatePicker: UITextField!
    @IBOutlet weak var txtDistrictPicker: UITextField!
    @IBOutlet weak var txtDDatePicker: UITextField!
    
    let datePicker = UIDatePicker()
    let dDatePicker = UIDatePicker()
    
    private var webservice :WebServices!
    
    var selectedState: StateViewModel?
    let statePickerView = UIPickerView()
    var statesListViewModel: StatesListViewModel!
    
    var selectedDistrict: DistrictViewModel?
    let districtPickerView = UIPickerView()
    var districtsListViewModel: DistrictsListViewModel!
    
    var centersListViewModel: CentersListViewModel!
    
    var enteredPincode: String?
    var selectedDistrictId: Int?
    var selectedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
        dDatePicker.preferredDatePickerStyle = .wheels
        txtPincode.delegate = self
        txtDateForVaccination.addCancelDoneOnKeyboardWithTarget(self, cancelAction: #selector(cancelDatePicker), doneAction: #selector(donedatePicker))
        txtDDatePicker.addCancelDoneOnKeyboardWithTarget(self, cancelAction: #selector(cancelDistrictDatePicker), doneAction: #selector(doneDistrictDatePicker))
        setDatePicker()
        setDistrictDatePicker()
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_IN") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd-MM-yyyy"
        datePicker.minimumDate = Date()
        self.txtDateForVaccination.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtDateForVaccination.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.txtDateForVaccination.text = ""
        self.view.endEditing(true)
    }
    
    func setDistrictDatePicker() {
        dDatePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_IN") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dDatePicker.minimumDate = Date()
        self.txtDDatePicker.inputView = dDatePicker
    }
    
    @objc func doneDistrictDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtDDatePicker.text = formatter.string(from: dDatePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDistrictDatePicker(){
        self.txtDDatePicker.text = ""
        self.view.endEditing(true)
    }

    @IBAction func actionSearchWithPincode(_ sender: UIButton) {
        if let pincode = txtPincode.text, let date = txtDateForVaccination.text {
            self.selectedDistrictId = nil
            self.enteredPincode = pincode
            self.selectedDate = date
            self.performSegue(withIdentifier: SegueIdentifier.showCentersList, sender: self)
        }
    }
    
    @IBAction func actionSearchWithDistrict(_ sender: UIButton) {
        if let districtId = self.selectedDistrict?.districtId, let date = self.txtDDatePicker.text  {
            self.enteredPincode = nil
            self.selectedDistrictId = districtId
            self.selectedDate = date
            self.performSegue(withIdentifier: SegueIdentifier.showCentersList, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showCentersList {
            if let viewController = segue.destination as? VaccinationCentersVC {
                viewController.date = selectedDate
                viewController.pincode = enteredPincode
                viewController.districtId = selectedDistrictId
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPincode {
            let maxLength = 6
                let currentString: NSString = (textField.text ?? "") as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
        }
        return true
    }
    
    @IBAction func toShowStateDistrictView(_ sender: UIButton) {
        callStateAPI()
        viewSearchWithDistrict.isHidden = false
        viewSearchWithPinCode.isHidden = true
    }
    
    @IBAction func toShowPincodeView(_ sender: UIButton) {
        viewSearchWithPinCode.isHidden = false
        viewSearchWithDistrict.isHidden = true
    }

}

//MARK: - Picker for State
extension SearchForVaccinationVC {
    
    private func callStateAPI() {
        
        self.webservice = WebServices()
        self.statesListViewModel = StatesListViewModel(webservice: self.webservice)
        
        // setting up the bindings
        self.statesListViewModel.bindToStateViewModels = { [unowned self] in
            self.setupPickerViewForState()
        }
        
    }
    
    private func setupPickerViewForState(){
        statePickerView.delegate = self
        statePickerView.backgroundColor = .white
        txtStatePicker.inputView = statePickerView
    
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClickState))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClickState))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtStatePicker.inputAccessoryView = toolBar
    }
    
    @objc func doneClickState() {
        if txtStatePicker.text!.isEmpty{
            self.selectedState = self.statesListViewModel.state(at: 0)
            txtStatePicker.text = self.statesListViewModel.state(at: 0).stateName
            self.callDistrictAPI(withStateId: self.statesListViewModel.state(at: 0).stateId)
            self.selectedDistrict = nil
            txtDistrictPicker.text = ""
        }
        txtStatePicker.resignFirstResponder()
    }
    
    @objc func cancelClickState() {
        txtStatePicker.text = ""
        txtStatePicker.resignFirstResponder()
    }
}

//MARK: - Picker for District
extension SearchForVaccinationVC {
    
    private func callDistrictAPI(withStateId id: Int) {
        
        self.webservice = WebServices()
        self.districtsListViewModel = DistrictsListViewModel(webservice: webservice, stateId: id)
        
        // setting up the bindings
        self.districtsListViewModel.bindToDistrictViewModels = { [unowned self] in
            self.setupPickerViewForDistrict()
        }
        
    }
    
    private func setupPickerViewForDistrict(){
        districtPickerView.delegate = self
        districtPickerView.backgroundColor = .white
        txtDistrictPicker.inputView = districtPickerView
    
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClickDistrict))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClickDistrict))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtDistrictPicker.inputAccessoryView = toolBar
    }
    
    @objc func doneClickDistrict() {
        if txtDistrictPicker.text!.isEmpty{
            self.selectedDistrict = self.districtsListViewModel.district(at: 0)
            txtDistrictPicker.text = self.districtsListViewModel.district(at: 0).districtName
        }
        txtDistrictPicker.resignFirstResponder()
    }
    
    @objc func cancelClickDistrict() {
        txtDistrictPicker.text = ""
        txtDistrictPicker.resignFirstResponder()
    }
}

//MARK: - Picker Delegate
extension SearchForVaccinationVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePickerView {
            return statesListViewModel.stateViewModels.count
        } else {
            return districtsListViewModel.districtViewModels.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePickerView {
            return self.statesListViewModel.state(at: row).stateName
        } else {
            return self.districtsListViewModel.district(at: row).districtName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePickerView {
            self.selectedState = self.statesListViewModel.state(at: row)
            txtStatePicker.text = self.statesListViewModel.state(at: row).stateName
            self.callDistrictAPI(withStateId: self.statesListViewModel.state(at: row).stateId)
            self.selectedDistrict = nil
            txtDistrictPicker.text = ""
        } else {
            self.selectedDistrict = self.districtsListViewModel.district(at: row)
            txtDistrictPicker.text = self.districtsListViewModel.district(at: row).districtName
        }
    }
}
