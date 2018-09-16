//
//  FilterViewUISetup.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import WARangeSlider

extension FilterViewController : CurrencyTextFieldDelegate {

    // HANDLER
    @objc func onSliderValueChange(_ sender : RangeSlider){
        maximumPriceTextField.text = IntegerLiteralType(sender.upperValue).round(for: 2).priceFormatter(currency : "Rp")
        minimumPriceTextField.text = IntegerLiteralType(sender.lowerValue).round(for: 2).priceFormatter(currency : "Rp")
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        if let tapGesture : UITapGestureRecognizer = keyboardTapGesture {
            tapGesture.removeTarget(self, action: #selector(self.dismissKeyboard))
            view.removeGestureRecognizer(tapGesture)
        }
    }
    
    // TEXTFIELD DELEGATE
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardTapGesture = keyboardTapGesture ?? UITapGestureRecognizer()
        keyboardTapGesture?.addTarget(self, action: #selector(self.dismissKeyboard))
        keyboardTapGesture?.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardTapGesture!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == maximumPriceTextField {
            maximumPriceTextField.text = Int(rangeSlider.upperValue).priceFormatter(currency: "Rp")
        }
        else if textField == minimumPriceTextField {
            minimumPriceTextField.text = Int(rangeSlider.lowerValue).priceFormatter(currency: "Rp")
        }
    }
    
    func currencyTextField(_ currencyTextField: CurrencyTextField, onValueChangeTo value: Int) -> Int? {
        let value = value < 0 ? 0 : (value > Int(rangeSlider.maximumValue) ? Int(rangeSlider.maximumValue) : value)
        let doubleValue = Double(value)
        if currencyTextField == maximumPriceTextField {
            rangeSlider.upperValue = rangeSlider.lowerValue > doubleValue ? rangeSlider.lowerValue : doubleValue
        }
        else if currencyTextField == minimumPriceTextField {
            rangeSlider.lowerValue = rangeSlider.upperValue < doubleValue ? rangeSlider.upperValue : doubleValue
        }
        return value
    }
    
    // UI SETUP
    
    func createNavigationBar(with dismissHandler : Selector, and resetHandler : Selector) -> UINavigationBar {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navBar = UINavigationBar()
        navBar.frame.size = CGSize.init(width: screenSize.width, height: 44)
        
        let navItem = UINavigationItem(title: "Filter")
        
        let dismissButton = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: dismissHandler)
        navItem.leftBarButtonItem = dismissButton
        
        let resetButton = UIBarButtonItem.init(title: "Reset", style: .plain, target: self, action: resetHandler)
        resetButton.tintColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        navItem.rightBarButtonItem = resetButton
        
        
        navBar.setItems([navItem], animated: false)
        navBar.backgroundColor = #colorLiteral(red: 0.9591727475, green: 0.9591727475, blue: 0.9591727475, alpha: 1)
        navBar.tintColor = UIColor.gray
        navBar.elevation = 1
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        let topView = UIView()
        topView.backgroundColor = #colorLiteral(red: 0.9591727475, green: 0.9591727475, blue: 0.9591727475, alpha: 1)
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(navBar)
        self.view.addSubview(topView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            navBar.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.bottomAnchor.constraint(equalTo: guide.topAnchor)
            ])
        return navBar
    }
    
    func createPriceFilterSection(maximumValue : Double, topAnchorConstraint topAnchor : NSLayoutYAxisAnchor, margin : CGFloat) -> (UIView, CurrencyTextField, CurrencyTextField, RangeSlider, UISwitch){
        let viewCard = UIView()
        viewCard.backgroundColor = #colorLiteral(red: 0.9591727475, green: 0.9591727475, blue: 0.9591727475, alpha: 1)
        viewCard.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        viewCard.layer.borderWidth = 1
        viewCard.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewCard)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            viewCard.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            viewCard.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            viewCard.topAnchor.constraint(equalTo: topAnchor)
            ])
        
        let textFields = setupPriceFilterTextView(maximumValue: maximumValue, for: viewCard, margin)
        let slider = setupPriceFilterSlider(maximumValue: maximumValue, for: viewCard, topAnchor: textFields.0.bottomAnchor, margin * 2)
        let wholeSaleSwitch = setupWholeSale(for: viewCard, topAnchor: slider.bottomAnchor, margin)
        
        self.view.sendSubview(toBack: viewCard)
        return (viewCard, textFields.0, textFields.1, slider, wholeSaleSwitch)
    }
    
    func setupPriceFilterTextView(maximumValue : Double, for containerView : UIView, _ margin : CGFloat) -> (CurrencyTextField, CurrencyTextField){
        let maxLabel = UILabel()
        maxLabel.text = "Maximum Price"
        maxLabel.font = UIFont.systemFont(ofSize: 14)
        maxLabel.textColor = UIColor.lightGray
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let minLabel = UILabel()
        minLabel.text = "Minimum Price"
        minLabel.font = UIFont.systemFont(ofSize: 14)
        minLabel.textColor = UIColor.lightGray
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(minLabel)
        containerView.addSubview(maxLabel)
        
        let maxTextField = CurrencyTextField()
        maxTextField.currency = "Rp"
        maxTextField.placeholder = Int(maximumValue).priceFormatter(currency: "Rp")
        maxTextField.textColor = UIColor.darkGray
        maxTextField.keyboardType = .decimalPad
        maxTextField.font = UIFont.systemFont(ofSize: 15)
        maxTextField.textAlignment = .right
        maxTextField.delegate = self
        maxTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let maxTextUnderline = UIView()
        maxTextUnderline.backgroundColor = UIColor.lightGray
        maxTextUnderline.translatesAutoresizingMaskIntoConstraints = false
        
        let minTextField = CurrencyTextField()
        minTextField.currency = "Rp"
        minTextField.placeholder = "Rp 0"
        minTextField.textColor = UIColor.darkGray
        minTextField.keyboardType = .decimalPad
        minTextField.font = UIFont.systemFont(ofSize: 15)
        minTextField.delegate = self
        minTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let minTextUnderline = UIView()
        minTextUnderline.backgroundColor = UIColor.lightGray
        minTextUnderline.translatesAutoresizingMaskIntoConstraints = false
        
        let stripe = UIView()
        stripe.backgroundColor = UIColor.lightGray
        stripe.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stripe)
        containerView.addSubview(minTextField)
        containerView.addSubview(maxTextField)
        containerView.addSubview(minTextUnderline)
        containerView.addSubview(maxTextUnderline)
        
        NSLayoutConstraint.activate([
            minLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            minLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: margin),
            
            containerView.trailingAnchor.constraint(equalTo: maxLabel.trailingAnchor, constant: margin),
            maxLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: margin),
            
            minTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            minTextField.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: margin),
            
            minTextUnderline.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            minTextUnderline.topAnchor.constraint(equalTo: minTextField.bottomAnchor, constant: margin / 2),
            minTextUnderline.heightAnchor.constraint(equalToConstant: 1),
            
            containerView.trailingAnchor.constraint(equalTo: maxTextField.trailingAnchor, constant: margin),
            maxTextField.topAnchor.constraint(equalTo: maxLabel.bottomAnchor, constant: margin),
            
            containerView.trailingAnchor.constraint(equalTo: maxTextUnderline.trailingAnchor, constant: margin),
            maxTextUnderline.topAnchor.constraint(equalTo: maxTextField.bottomAnchor, constant: margin / 2),
            maxTextUnderline.heightAnchor.constraint(equalToConstant: 1),
            
            stripe.centerYAnchor.constraint(equalTo: minTextField.centerYAnchor),
            stripe.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stripe.heightAnchor.constraint(equalToConstant: 1),
            stripe.widthAnchor.constraint(equalToConstant: 9),
            
            stripe.leadingAnchor.constraint(equalTo: minTextField.trailingAnchor, constant: margin),
            maxTextField.leadingAnchor.constraint(equalTo: stripe.trailingAnchor, constant: margin),
            stripe.leadingAnchor.constraint(equalTo: minTextUnderline.trailingAnchor, constant: margin),
            maxTextUnderline.leadingAnchor.constraint(equalTo: stripe.trailingAnchor, constant: margin),
            
            ])
        return (minTextField, maxTextField)
    }
    
    func setupPriceFilterSlider(maximumValue : Double, for containerView : UIView, topAnchor : NSLayoutYAxisAnchor, _ margin : CGFloat) -> RangeSlider {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        var i = 0
        while(i < 6){
            let bar = UIView.init()
            bar.backgroundColor = UIColor.clear
            let leftLine = UIView.init()
            leftLine.backgroundColor = UIColor.lightGray
            let rightLine = UIView.init()
            rightLine.backgroundColor = UIColor.lightGray
            
            leftLine.translatesAutoresizingMaskIntoConstraints = false
            rightLine.translatesAutoresizingMaskIntoConstraints = false
            
            bar.addSubview(leftLine)
            bar.addSubview(rightLine)
            
            NSLayoutConstraint.activate([
                leftLine.widthAnchor.constraint(equalToConstant: i == 0 ? 1 : 0.5),
                leftLine.topAnchor.constraint(equalTo: bar.topAnchor),
                leftLine.bottomAnchor.constraint(equalTo: bar.bottomAnchor),
                leftLine.leadingAnchor.constraint(equalTo: bar.leadingAnchor),
                
                rightLine.widthAnchor.constraint(equalToConstant: i == 5 ? 1 : 0.5),
                rightLine.topAnchor.constraint(equalTo: bar.topAnchor),
                rightLine.bottomAnchor.constraint(equalTo: bar.bottomAnchor),
                rightLine.trailingAnchor.constraint(equalTo: bar.trailingAnchor)
                ])
            stackView.addArrangedSubview(bar)
            i += 1
        }
        
        let slider = RangeSlider()
        slider.maximumValue = maximumValue
        slider.minimumValue = 0
        slider.lowerValue = 0
        slider.upperValue = maximumValue
        slider.thumbBorderWidth = 2
        slider.thumbBorderColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        slider.trackHighlightTintColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        slider.addTarget(self, action: #selector(onSliderValueChange(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        containerView.addSubview(slider)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: margin),
            stackView.heightAnchor.constraint(equalToConstant: 12),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            
            slider.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: margin),
            slider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: slider.trailingAnchor, constant : margin),
            slider.heightAnchor.constraint(equalToConstant: 45)
            ])
        return slider
    }
    
    func setupWholeSale(for containerView : UIView, topAnchor : NSLayoutYAxisAnchor, _ margin : CGFloat) -> UISwitch {
        let sw = UISwitch()
        sw.onTintColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        sw.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Whole Sale"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(sw)
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            sw.topAnchor.constraint(equalTo: topAnchor, constant: margin * 2),
            containerView.trailingAnchor.constraint(equalTo: sw.trailingAnchor, constant : margin),
            containerView.bottomAnchor.constraint(equalTo: sw.bottomAnchor, constant : margin),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant : margin),
            label.centerYAnchor.constraint(equalTo: sw.centerYAnchor)
            ])
        return sw
    }
    
    func createApplyButton(onClick handler : Selector) -> UIButton {
        
        let applyButton = UIButton()
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel?.textColor = UIColor.white
        applyButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        
        applyButton.addTarget(self, action: handler, for: .touchUpInside)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(applyButton)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            guide.bottomAnchor.constraint(equalTo: applyButton.bottomAnchor),
            applyButton.heightAnchor.constraint(equalToConstant: 54)
            ])
        return applyButton
    }
}
