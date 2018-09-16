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
    weak var shopTypeCollection : UICollectionView!
    //VARIABLE
    
    var filter : Filter!
    
    var maximumPriceForSlider : Int!
    
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
        let actionHandler = setupPriceFilter(maximumValue: Double(maximumPriceForSlider), topAnchorConstraint: navigationBar.bottomAnchor, margin: 12)
        let priceFilterCard = actionHandler.0
        minimumPriceTextField = actionHandler.1
        maximumPriceTextField = actionHandler.2
        rangeSlider = actionHandler.3
        wholeSaleSwitch = actionHandler.4
        shopTypeCollection = setupShopType(topAnchorConstraint: priceFilterCard.bottomAnchor, margin: 12, goToShopType: #selector(goToShopTypeDetails(_:)))
        applyButton = setupApplyButton(onClick: #selector(apply(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        maximumPriceTextField.text = filter.maximumPrice.priceFormatter(currency: "Rp")
        minimumPriceTextField.text = filter.minimumPrice.priceFormatter(currency: "Rp")
        rangeSlider.upperValue = Double(filter.maximumPrice)
        rangeSlider.lowerValue = Double(filter.minimumPrice)
        wholeSaleSwitch.isOn = filter.wholeSale
    }
    
    // HANDLER
    
    @objc func goToShopTypeDetails(_ sender : UIButton){
        let vc = ShopTypeViewController()
        vc.goldMerchantSelected = filter.goldMerchant
        vc.officialSelected = filter.officialStore
        present(vc, animated: true, completion: nil)
    }
    
    @objc func apply(_ sender : UIButton){
        if let mainVC : MainViewController = presentingViewController as? MainViewController {
            mainVC.filter.maximumPrice = maximumPrice
            mainVC.filter.minimumPrice = minimumPrice
            mainVC.filter.wholeSale = wholeSaleSwitch.isOn
            mainVC.filter.goldMerchant = filter.goldMerchant
            mainVC.filter.officialStore = filter.officialStore
            mainVC.requestForResult(for: mainVC.KEY_FOR_SEARCH, with: mainVC.filter, startIndex: 0, count: 10)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismiss(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onResetClicked(_ sender : UIButton){
        if let mainVC : MainViewController = presentingViewController as? MainViewController {
            maximumPriceTextField.text = mainVC.MAX_PRICE_HARD_CODED.priceFormatter(currency: "Rp")
            minimumPriceTextField.text = "Rp 0"
            wholeSaleSwitch.isOn = false
            rangeSlider.upperValue = Double(mainVC.MAX_PRICE_HARD_CODED)
            rangeSlider.lowerValue = 0
            filter = Filter()
        }
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
