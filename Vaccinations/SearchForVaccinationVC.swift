//
//  SearchForVaccinationVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 04/07/21.
//

import UIKit

class SearchForVaccinationVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtDateForVaccination: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
        txtPincode.delegate = self
        txtDateForVaccination.addCancelDoneOnKeyboardWithTarget(self, cancelAction: #selector(cancelDatePicker), doneAction: #selector(donedatePicker))
        setDatePicker()
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

    @IBAction func actionSearch(_ sender: UIButton) {
        
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

}

