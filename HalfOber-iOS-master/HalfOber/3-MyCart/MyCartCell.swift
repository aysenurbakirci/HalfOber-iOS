//
//  MyCartCell.swift
//  HalfOber
//
//  Created by Ayşe Nur Bakırcı on 4.08.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class MyCartCell: UITableViewCell {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var orderCount: UILabel!
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
