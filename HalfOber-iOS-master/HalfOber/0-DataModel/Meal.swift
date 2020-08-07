//
//  Meal.swift
//  HalfOber
//
//  Created by Müge EREL on 9.07.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import Foundation
import ObjectMapper

class Meal: Mappable {
    var mealId: Int?
    var mealName: String?
    var mealDescription: String?
    var mealCalory: Int?
    var mealPrice : Double?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        mealId <- map["mealId"]
        mealName <- map["mealName"]
        mealDescription <- map["mealDescription"]
        mealCalory <- map["mealCalory"]
        mealPrice <- map["mealPrice"]
    }
}
