//
//  MyCartController.swift
//  HalfOber
//
//  Created by Müge EREL on 22.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class MyCartController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var confirmCart: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if((self.tabBarController as! TabBarController).cartItemCount > 0){
            confirmCart.isEnabled = true
        } else{
            confirmCart.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)

        //tab bar sayfalarına back button eklenmek istenirse aşağıdaki iki metoddan biri kullanılabilir
        //self.navigationItem.setLeftBarButton(UIBarButtonItem(title:"< Back", style: .plain, target: self, action: #selector(test)), animated: true)

        /*let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_button"), for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(test), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)*/
        
        // Do any additional setup after loading the view.
    }
    
    /*@objc func test(){
        NSLog("****test")
        self.dismiss(animated: false, completion: nil)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (self.tabBarController as! TabBarController).cartItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MyCartCell", bundle: nil), forCellReuseIdentifier: "MyCartCell")
        let thisCell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell") as! MyCartCell
        thisCell.backgroundColor = UIColor.clear
        thisCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if let cartItem = (self.tabBarController as! TabBarController).cartItemList[indexPath.row] as? CartItem{
            let mealName = cartItem.mealName
            let mealPrice = cartItem.mealPrice
            let cartItemCount = cartItem.cartItemCount
            thisCell.mealName.text = mealName!
            thisCell.orderCount.text = "\(cartItemCount!)"
            thisCell.orderPrice.text = "\(mealPrice! * Double(cartItemCount!))"
        }
        return thisCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let tbc = self.tabBarController as! TabBarController
            if let cartItem = tbc.cartItemList[indexPath.row] as? CartItem{
                tbc.cartItemList.removeObject(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tbc.cartItemCount -= cartItem.cartItemCount!
                if(tbc.cartItemCount == 0){
                    self.tabBarController?.tabBar.items?[1].badgeValue = nil
                    confirmCart.isEnabled = false
                } else{
                    self.tabBarController?.tabBar.items?[1].badgeValue = "\(tbc.cartItemCount)"
                }
            }

        }
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

    @IBAction func ConfirmCart(_ sender: Any) {
        
        let tbc = self.tabBarController as! TabBarController
        for item in tbc.cartItemList {
            tbc.paymentList.add(item)
        }
        tbc.cartItemList.removeAllObjects()
        tableView.reloadData()
        tbc.cartItemCount = 0
        
        self.tabBarController?.tabBar.items?[1].badgeValue = nil
        
        self.tabBarController?.selectedIndex = 2
    }
}
