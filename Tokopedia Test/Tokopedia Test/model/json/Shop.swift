//
//  Shop.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import HandyJSON

class Shop : HandyJSON {
    
    var id : Int64?
    var name : String?
    var uri : String?
    var is_gold : Int?
    var rating : Int?
    var location : String?
    var reputation_image_uri : String?
    var shop_lucky : String?
    var city : String?
    
    required init(){}
    
}
