//
//  PaymentController.swift
//  HalfOber
//
//  Created by Müge EREL on 22.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class PaymentController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if((self.tabBarController as! TabBarController).paymentList.count > 0){
            
            paymentButton.isEnabled = true
            
            let tbc = self.tabBarController as! TabBarController
            totalPrice.text = "\(tbc.totalOrderPrice)"
            
        } else{
            paymentButton.isEnabled = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
       // UserDefaults.standard.set(((self.tabBarController as! TabBarController).paymentList), forKey: "paymentList")
        // Do any additional setup after loading the view.
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
        let alert = UIAlertController(title: "Payment", message: "Please select your payment method", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cash Payment", style: .default, handler: CashPayment))
        alert.addAction(UIAlertAction(title: "Credit Card Payment", style: .default, handler: CreditCardPayment))
        alert.addAction(UIAlertAction(title: "Mobile Payment", style: .default, handler: MobilePayment))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func CashPayment(alert: UIAlertAction!){
        PaymentSuccessful()
    }
    
    func CreditCardPayment(alert: UIAlertAction!){
        PaymentFailed()
    }
    
    func MobilePayment(alert: UIAlertAction!){
        PaymentSuccessful()
    }
    
    func PaymentSuccessful(){
        
        let tbc = self.tabBarController as! TabBarController
        tbc.paymentList.removeAllObjects()
        tableView.reloadData()
        tbc.totalOrderPrice = 0.0
        totalPrice.text = "00.00"
        paymentButton.isEnabled = false
        
        let alert = UIAlertController(title: "Payment Successful", message: "Your payment request has been sent.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        subview.backgroundColor = UIColor(red: (70/255.0), green: (170/255.0), blue: (20/255.0), alpha: 1.0)
        alert.setTitleColor(color: UIColor.white)
        alert.setMessageColor(color: UIColor.white)
        alert.setButtonColor(color: UIColor.white)
        

    }
    
    func PaymentFailed(){
        let alert = UIAlertController(title: "Payment Fail", message: "Your payment request could not be sent. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        subview.backgroundColor = UIColor(red: (200/255.0), green: (20/255.0), blue: (10/255.0), alpha: 1.0)
        alert.setTitleColor(color: UIColor.white)
        alert.setMessageColor(color: UIColor.white)
        alert.setButtonColor(color: UIColor.white)
        
    }
}

extension UIAlertController {

    func setTitleColor(color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    func setMessageColor(color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)

        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    func setButtonColor(color: UIColor) {
        self.view.tintColor = color
    }
}
