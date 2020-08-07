//
//  MainMenuController.swift
//  HalfOber
//
//  Created by Müge EREL on 21.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {

    
    @IBOutlet weak var faQRIcon: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faQRIcon.text = "\u{f029}"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BtnScanQR(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //let vc = sb.instantiateViewController(withIdentifier: "QRScannerController") as! QRScannerController
        let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Refectory", comment: "Refectory"), style: UIBarButtonItem.Style.done, target: nil, action: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.tableId = 1
        self.present(vc, animated: false)
    }

}
