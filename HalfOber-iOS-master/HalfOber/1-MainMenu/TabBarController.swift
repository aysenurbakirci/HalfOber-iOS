//
//  TabBarController.swift
//  HalfOber
//
//  Created by Müge EREL on 22.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let selectedTitleColor = UIColor.black
    var tableId = 0
    var cartItemCount = 0
    var cartItemList : NSMutableArray = []
    var paymentList : NSMutableArray = []
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedTitleColor], for: .selected)
        
        let imageMenu = ConvertFAToImage(fromChar:"\u{f022}", color: UIColor.black, size: 26.0)
        self.tabBar.items![0].image = imageMenu
        let imageCart = ConvertFAToImage(fromChar:"\u{f291}", color: UIColor.black, size: 26.0)
        self.tabBar.items![1].image = imageCart
        //self.tabBar.items![1].badgeValue = "5"
        let imagePayment = ConvertFAToImage(fromChar:"\u{f09d}", color: UIColor.black, size: 26.0)
        self.tabBar.items![2].image = imagePayment
        
        //self.selectedIndex = 2
        
        // Do any additional setup after loading the view.
    }
    
    func ConvertFAToImage(fromChar char: String,
                             color: UIColor,
                             size: CGFloat) -> UIImage {
        // 1.
        let label = UILabel(frame: .zero)
        label.textColor = color
        label.font = UIFont(name: "FontAwesome", size: size)
        label.text = char
        // 2.
        label.sizeToFit()
        
        // 3.
        let renderer = UIGraphicsImageRenderer(size: label.frame.size)
        
        // 4.
        let image = renderer.image(actions: { context in
            // 5.
            label.layer.render(in: context.cgContext)
        })
        
        return image
    }
    
}
