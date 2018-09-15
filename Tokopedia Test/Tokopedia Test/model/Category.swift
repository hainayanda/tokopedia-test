//
//  Category.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation

class Category {
    var data : [String : CategoryData]?
    var selected_id : String?
    
    required init(){}
}

class CategoryData {
    var id : Int?
    var name : String?
    var total_data : Int?
    var parent_id : Int?
    var child_id : [Int]?
    var level : Int?
    
    required init(){}
}
