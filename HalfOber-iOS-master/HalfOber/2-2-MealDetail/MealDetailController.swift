//
//  MealDetailController.swift
//  HalfOber
//
//  Created by Müge EREL on 24.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class MealDetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var mealTitle: UILabel!
    @IBOutlet var orderCount: UITextField!
    @IBOutlet var orderNote: UITextView!
    
    var mealId : Int = 0
    var mealName : String = ""
    var mealPrice : Double = 0
    var cartItemCount : Int = 0
    let thePicker = UIPickerView()
    let myPickerData = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thePicker.delegate = self
        orderCount.inputView = thePicker
        mealTitle.textAlignment = .center
        mealTitle.text = mealName
        // Do any additional setup after loading the view.
    }

    @IBAction func AddToCart(_ sender: Any) {
        if orderCount.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else{
            let cartItem = CartItem()
            cartItem.mealId = mealId
            cartItem.mealName = mealName
            cartItem.mealPrice = mealPrice
            cartItem.mealNote = orderNote.text
            cartItem.cartItemCount = Int(orderCount.text!)
            
            let tbc = self.tabBarController as! TabBarController
            tbc.cartItemCount += Int(orderCount.text!)!
            tbc.cartItemList.add(cartItem)
            tbc.totalPrice += Double(orderCount.text!)! * mealPrice
            self.tabBarController?.tabBar.items?[1].badgeValue = "\(tbc.cartItemCount)"
            self.navigationController?.popViewController(animated: true)
            //add item to cart
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return "\(myPickerData[row])"
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        orderCount.text = "\(myPickerData[row])"
        self.view.endEditing(true)
    }


}
