//
//  PaymentCell.swift
//  HalfOber
//
//  Created by Ayşe Nur Bakırcı on 5.08.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
