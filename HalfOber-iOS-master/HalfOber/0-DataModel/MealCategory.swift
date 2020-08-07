//
//  MealCategory.swift
//  HalfOber
//
//  Created by Müge EREL on 9.07.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import Foundation
import ObjectMapper

class MealCategory: Mappable {
    var categoryId: Int?
    var categoryName: String?
    var categoryDescription: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        categoryId <- map["categoryId"]
        categoryName <- map["categoryName"]
        categoryDescription <- map["categoryDescription"]
    }
}
