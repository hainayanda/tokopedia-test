//
//  ShopTypeViewController.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class ShopTypeViewController : UIViewController {
    
    // UI COMPONENT
    
    weak var navigationBar : UINavigationBar!
    weak var applyButton : UIButton!
    
    //OVERRIDE
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        navigationBar = setupNavbar(with: #selector(dismiss(_:)), and: #selector(onResetClicked(_:)))
        applyButton = setupApplyButton(onClick: #selector(apply(_:)))
    }
    
    // HANDLER
    
    @objc func apply(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismiss(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onResetClicked(_ sender : UIButton){
        
    }
    
    // UI SETUP
    
    func setupNavbar(with dismissHandler : Selector, and resetHandler : Selector) -> UINavigationBar {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navBar = UINavigationBar()
        navBar.frame.size = CGSize.init(width: screenSize.width, height: 44)
        
        let navItem = UINavigationItem(title: "Shop Type")
        
        let dismissButton = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: dismissHandler)
        navItem.leftBarButtonItem = dismissButton
        
        let resetButton = UIBarButtonItem.init(title: "Reset", style: .plain, target: self, action: resetHandler)
        resetButton.tintColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        navItem.rightBarButtonItem = resetButton
        
        
        navBar.setItems([navItem], animated: false)
        navBar.backgroundColor = #colorLiteral(red: 0.9591727475, green: 0.9591727475, blue: 0.9591727475, alpha: 1)
        navBar.tintColor = UIColor.gray
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
    
    func setupApplyButton(onClick handler : Selector) -> UIButton {
        
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
