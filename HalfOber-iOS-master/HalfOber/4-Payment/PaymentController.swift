//
//  PaymentController.swift
//  HalfOber
//
//  Created by Müge EREL on 22.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class PaymentController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var paymentMethod: UITextField!
    @IBOutlet weak var paymentButton: UIButton!
    
    var total = 0.0
    let thePicker = UIPickerView()
    let myPickerData = [String](arrayLiteral: "Credit Card", "Cash", "Mobile")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if((self.tabBarController as! TabBarController).paymentList.count > 0){
            paymentButton.isEnabled = true
        } else{
            paymentButton.isEnabled = false
        }
        
        total = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thePicker.delegate = self
        paymentMethod.inputView = thePicker
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)

       // UserDefaults.standard.set(((self.tabBarController as! TabBarController).paymentList), forKey: "paymentList")
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return "\(myPickerData[row])"
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentMethod.text = "\(myPickerData[row])"
        self.view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tabBarController as! TabBarController).paymentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "PaymentCell", bundle: nil), forCellReuseIdentifier: "PaymentCell")
        let thisCell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell") as! PaymentCell
        thisCell.backgroundColor = UIColor.clear
        thisCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if let cartItem = (self.tabBarController as! TabBarController).paymentList[indexPath.row] as? CartItem{
            let mealName = cartItem.mealName
            let mealPrice = cartItem.mealPrice
            let cartItemCount = cartItem.cartItemCount
            thisCell.mealName.text = mealName!
            thisCell.orderPrice.text = "\(mealPrice! * Double(cartItemCount!))"
            
            total += Double(thisCell.orderPrice.text!)!
            totalPrice.text = "\(total)"
        }
        return thisCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        // Remove separator inset
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    @IBAction func PaymentButtonClick(_ sender: Any) {
        
        if paymentMethod.text == "Mobile"{
            let alert = UIAlertController(title: "Payment", message: "Mobile Payment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if paymentMethod.text == "Credit Card"{
            let alert = UIAlertController(title: "Payment", message: "Credit Card Payment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if paymentMethod.text == "Cash"{
            let alert = UIAlertController(title: "Payment", message: "Cash Payment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Payment Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
