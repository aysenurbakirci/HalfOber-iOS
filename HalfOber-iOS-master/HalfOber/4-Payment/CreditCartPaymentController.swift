//
//  CreditCartPaymentController.swift
//  HalfOber
//
//  Created by Ayşe Nur Bakırcı on 31.08.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class CreditCartPaymentController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var creditCartNumber: UITextField!
    @IBOutlet weak var expiretionDateMonth: UITextField!
    @IBOutlet weak var expiretionDateYear: UITextField!
    @IBOutlet weak var cartCvvNumber: UITextField!
    
    let months = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let years = [Int](arrayLiteral: 2020, 2021, 2022, 2023, 2024, 2025, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 2038, 2039, 2040)
    let thePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thePicker.delegate = self
        expiretionDateMonth.inputView = thePicker
        expiretionDateYear.inputView = thePicker
        // Do any additional setup after loading the view.
    }
    @IBAction func PaymentConfirm(_ sender: Any) {
        
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){

            return months.count

        }else{

            return years.count

        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0){
            
            return "\(months[row])"
            
        }
        else{
            
            return "\(years[row])"
            
        }
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            expiretionDateMonth.text = "\(months[row])"

        }else{
            expiretionDateYear.text = "\(years[row])"

        }
    }
    

}
