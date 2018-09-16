//
//  ShopTypeViewController.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class ShopTypeViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // UI COMPONENT
    
    weak var tableView : UITableView!
    weak var navigationBar : UINavigationBar!
    weak var applyButton : UIButton!
    
    //CONSTANT
    
    let cellId = "shopType"
    
    //VARIABLE
    
    var goldMerchantSelected = false
    var officialSelected = false
    
    //OVERRIDE
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        navigationBar = createNavigationBar(with: #selector(dismiss(_:)), and: #selector(onResetClicked(_:)))
        applyButton = createApplyButton(onClick: #selector(apply(_:)))
        tableView = createTableView(topAnchor: navigationBar.bottomAnchor, bottomAnchor: applyButton.topAnchor)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // HANDLER
    
    @objc func apply(_ sender : UIButton){
        if let presenter : FilterViewController = presentingViewController as? FilterViewController {
            presenter.filter.goldMerchant = goldMerchantSelected
            presenter.filter.officialStore = officialSelected
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismiss(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onResetClicked(_ sender : UIButton){
        (tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ShopTypeRadioButtonCell).radioButton.isSelected = false
        (tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! ShopTypeRadioButtonCell).radioButton.isSelected = false
        goldMerchantSelected = false
        officialSelected = false
    }
    
    // DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as! ShopTypeRadioButtonCell
        cell.radioButton.isSelected = !(cell.radioButton.isSelected)
        if indexPath.item == 0 {
            goldMerchantSelected = cell.radioButton.isSelected
        }
        else {
            officialSelected = cell.radioButton.isSelected
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ShopTypeRadioButtonCell
        cell.label.text = indexPath.item == 0 ? "Gold Merchant" : "Official Store"
        cell.radioButton.isSelected = indexPath.item == 0 ? goldMerchantSelected : officialSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    // UI SETUP
    
    func createNavigationBar(with dismissHandler : Selector, and resetHandler : Selector) -> UINavigationBar {
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
    
    func createTableView(topAnchor: NSLayoutYAxisAnchor, bottomAnchor : NSLayoutYAxisAnchor) -> UITableView{
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.backgroundColor = UIColor.lightGray
        tableView.separatorColor = UIColor.lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        self.view.sendSubview(toBack: tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            tableView.topAnchor.constraintEqualToSystemSpacingBelow(topAnchor, multiplier: 1)
            ])
        
        tableView.register(ShopTypeRadioButtonCell.self, forCellReuseIdentifier: cellId)
        
        return tableView
    }
    
}
