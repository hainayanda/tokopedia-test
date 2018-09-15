//
//  FilterViewController.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import WARangeSlider

class FilterViewController : UIViewController {
    
    // UI COMPONENT
    
    weak var navigationBar : UINavigationBar!
    weak var minimumPriceTextField : CurrencyTextField!
    weak var maximumPriceTextField : CurrencyTextField!
    weak var wholeSaleSwitch : UISwitch!
    weak var rangeSlider : RangeSlider!
    weak var applyButton : UIButton!
    
    // VARIABLE
    
    var maximumPrice : Int {
        return extractingValue(from: maximumPriceTextField)
    }
    
    var minimumPrice : Int {
        return extractingValue(from: minimumPriceTextField)
    }
    
    var keyboardTapGesture : UITapGestureRecognizer?
    
    // OVERRIDE
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        navigationBar = setupNavbar(with: #selector(dismiss(_:)), and: #selector(onResetClicked(_:)))
        let actionHandler = setupPriceFilter(maximumValue: 8000000, topAnchorConstraint: navigationBar.bottomAnchor, margin: 12)
        minimumPriceTextField = actionHandler.0
        maximumPriceTextField = actionHandler.1
        rangeSlider = actionHandler.2
        wholeSaleSwitch = actionHandler.3
        applyButton = setupApplyButton(onClick: #selector(apply(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let mainVC : MainViewController = presentingViewController as? MainViewController {
            maximumPriceTextField.text = mainVC.filter.maximumPrice.priceFormatter(currency: "Rp")
            minimumPriceTextField.text = mainVC.filter.minimumPrice.priceFormatter(currency: "Rp")
            rangeSlider.upperValue = Double(mainVC.filter.maximumPrice)
            rangeSlider.lowerValue = Double(mainVC.filter.minimumPrice)
            wholeSaleSwitch.isOn = mainVC.filter.wholeSale
        }
    }
    
    // HANDLER
    
    @objc func apply(_ sender : UIButton){
        if let mainVC : MainViewController = presentingViewController as? MainViewController {
            mainVC.filter.maximumPrice = maximumPrice
            mainVC.filter.minimumPrice = minimumPrice
            mainVC.filter.wholeSale = wholeSaleSwitch.isOn
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismiss(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onResetClicked(_ sender : UIButton){
        
    }
    
    // FUNCTION
    
    func extractingValue(from textField : UITextField) -> Int {
        guard let text : String = textField.text, text.count > 0 else {
            return 0
        }
        let currency : String = "Rp "
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
