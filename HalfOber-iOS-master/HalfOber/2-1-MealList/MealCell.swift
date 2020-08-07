//
//  MealCell.swift
//  HalfOber
//
//  Created by Müge EREL on 8.07.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet var mealName: UILabel!
    @IBOutlet var mealDescription: UILabel!
    @IBOutlet var mealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
