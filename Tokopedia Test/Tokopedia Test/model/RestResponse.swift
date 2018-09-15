//
//  RestResponse.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation

class RestResponse {
    var status : RestStatus?
    var header : RestHeader?
    var data : [ResultData]?
    var category : Category?
    
    required init(){}
}
