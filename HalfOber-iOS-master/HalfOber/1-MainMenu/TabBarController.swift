//
//  TabBarController.swift
//  HalfOber
//
//  Created by Müge EREL on 22.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController{
    
    let selectedTitleColor = UIColor.black
    var tableId = 0
    var cartItemCount = 0
    var cartItemList : NSMutableArray = []
    var paymentList : NSMutableArray = []
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedTitleColor], for: .selected)
        
        let imageMenu = ConvertFAToImage(fromChar:"\u{f022}", color: UIColor.red, size: 26.0)
        self.tabBar.items![0].image = imageMenu
        let imageCart = ConvertFAToImage(fromChar:"\u{f291}", color: UIColor.red, size: 26.0)
        self.tabBar.items![1].image = imageCart
        //self.tabBar.items![1].badgeValue = "5"
        let imagePayment = ConvertFAToImage(fromChar:"\u{f09d}", color: UIColor.red, size: 26.0)
        self.tabBar.items![2].image = imagePayment
        
        //self.selectedIndex = 2
        
        // Do any additional setup after loading the view.
    }
    
    func ConvertFAToImage(fromChar char: String,
                             color: UIColor,
                             size: CGFloat) -> UIImage {
        let label = UILabel(frame: .zero)
        label.textColor = color
        label.font = UIFont(name: "FontAwesome", size: size)
        label.text = char
        label.sizeToFit()
        
        let renderer = UIGraphicsImageRenderer(size: label.frame.size)
        
        let image = renderer.image(actions: { context in
            label.layer.render(in: context.cgContext)
        })
        
        return image
    }
}
extension TabBarController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        animateToTab(toIndex: toIndex)
        return true
    }

    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
            let selectedVC = selectedViewController else { return }

        guard let fromView = selectedVC.view,
            let toView = tabViewControllers[toIndex].view,
            let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
            fromIndex != toIndex else { return }


        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)

        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)

        // Disable interaction during animation
        view.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        // Slide the views by -offset
                        fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                        toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)

        }, completion: { finished in
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
}
