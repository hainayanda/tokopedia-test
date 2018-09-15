//
//  Item.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation

class ResultData
{
    var id: Int64?
    var name: String?
    var uri : String?
    var image_uri : String?
    var image_uri_700 : String?
    var price : String?
    var price_range : String?
    var category_breadcrumb: String?
    var shop : Shop?
    var wholesale_price : [WholeSalePrice]?
    var condition : Int?
    var preorder : Int?
    var department_id : Int?
    var rating : Int?
    var is_featured : Int?
    var count_review : Int?
    var count_talk : Int?
    var count_sold : Int?
    var labels : [Label]?
    var top_label : Label?
    var bottom_label : Label?
    var badges : [Badge]?
    var original_price : String?
    var discount_expired : String?
    var discount_start : String?
    var discount_percentage : Int?
    var stock : Int?
    
    required init(){}
    
}
