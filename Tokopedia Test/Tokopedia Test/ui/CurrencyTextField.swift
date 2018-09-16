//
//  CurrencyTextField.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class CurrencyTextField : UITextField {
    
    @IBInspectable var currency : String?
    
    var value : Int {
        set {
            set(intValue: newValue)
        }
        get {
            guard let text : String = self.text, text.count > 0 else {
                return 0
            }
            let currency : String = self.currency != nil ? self.currency! : ""
            var number = text
            if text.count > currency.count {
                for _ in currency {
                    number = String(number.dropFirst())
                }
            }
            let trimmed = number.replacingOccurrences(of: "\\D", with: "", options: .regularExpression, range: nil)
            if let result : Int = Int(trimmed) {
                return result
            }
            else {
                return 0
            }
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        registerForNotifications()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange), name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"), object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textDidChange(){
        let value = (delegate as? CurrencyTextFieldDelegate)?.currencyTextField(self, onValueChangeTo: self.value) ?? self.value
        set(intValue: value)
    }
    
    fileprivate func set(intValue : Int){
        if intValue == 0 {
            self.text = ""
            return
        }
        if let commaSeparated : String = intValue.asCommaSeparated {
            let currency : String = self.currency != nil ? self.currency! : ""
            self.text = "\(currency) \(commaSeparated)"
        }
        else {
            self.text = ""
        }
    }
}

protocol CurrencyTextFieldDelegate : UITextFieldDelegate {
    func currencyTextField(_ currencyTextField : CurrencyTextField, onValueChangeTo value : Int) -> Int?
}
