//
//  MainViewControllerAPIManager.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import Eatr

extension MainViewController {
    
    func requestForResult(for key : String, with filter: Filter, startIndex : Int, count: Int){
        guard !isRequesting else {
            return
        }
        isRequesting = true
        if startIndex < results.count {
            self.results = Array(self.results.dropLast(results.count - startIndex))
        }
        EatrRequestBuilder.httpGet.set(url: "https://ace.tokopedia.com/search/v2.5/product")
            .addParam(withKey: "q", andValue: key)
            .addParam(withKey: "pmin", andValue: "\(filter.minimumPrice)")
            .addParam(withKey: "pmax", andValue: "\(filter.maximumPrice)")
            .addParam(withKey: "wholesale", andValue: filter.wholeSale ? "true" : "false")
            .addParam(withKey: "official", andValue: filter.officialStore ? "true" : "false")
            .addParam(withKey: "fshop", andValue: filter.goldMerchant ? "2" : "1")
            .addParam(withKey: "start", andValue: "\(startIndex)")
            .set(operationQueue: operationQueue)
            .set(delegate: self)
            .asyncExecute()
    }
    
}
