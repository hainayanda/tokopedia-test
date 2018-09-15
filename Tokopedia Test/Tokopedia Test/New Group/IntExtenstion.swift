//
//  IntExtenstion.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
extension IntegerLiteralType {
    
    var asCommaSeparated : String? {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            return formatter.string(from: NSNumber(value:self))
        }
    }
    
    func priceFormatter(currency: String) -> String {
        let priceCommaSeparated : String = self.asCommaSeparated ?? "0"
        return "\(currency) \(priceCommaSeparated)"
    }
    
    func round(for nZero : Int) -> IntegerLiteralType {
        let divisor = pow(10, nZero)
        let rounded = self / (divisor as NSDecimalNumber).intValue
        return rounded * (divisor as NSDecimalNumber).intValue
    }
}
