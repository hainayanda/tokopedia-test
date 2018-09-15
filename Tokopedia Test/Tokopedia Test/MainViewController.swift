//
//  MainViewController.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 15/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var navigationBar : UINavigationBar!
    weak var filterButton : UIButton!
    weak var resultCollectionView : UICollectionView!
    // OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar = setupNavbar()
        filterButton = setupFilterButton()
        resultCollectionView = setupResultView(constraintFor: navigationBar.bottomAnchor, and: filterButton.topAnchor)
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
    }
    
    // HANDLER
    
    @objc func onBackPressed(_ sender : UIButton){
    
    }
    
    @objc func onFilterButtonPressed(_ sender : UIButton){
        
    }
    
    // COLLECTION VIEW DELEGATE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    // VIEW SETUP
    
    func setupNavbar() -> UINavigationBar {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navBar = UINavigationBar()
        navBar.frame.size = CGSize.init(width: screenSize.width, height: 44)
        
        let navItem = UINavigationItem(title: "Search")
        
        let backButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(onBackPressed(_:)))
        navItem.leftBarButtonItem = backButtonItem
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
    
    
    func setupResultView(constraintFor topAnchor : NSLayoutYAxisAnchor, and bottomAnchor : NSLayoutYAxisAnchor) -> UICollectionView {
        let resultView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        resultView.backgroundColor = UIColor.white
        resultView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(resultView)
        
        NSLayoutConstraint.activate([
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: resultView.bottomAnchor)
            ])
        return resultView
    }
    
    func setupFilterButton() -> UIButton {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let filterButton = UIButton()
        filterButton.frame.size = CGSize.init(width: screenSize.width, height: 54)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.titleLabel?.textColor = UIColor.white
        filterButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        
        filterButton.addTarget(self, action: #selector(onFilterButtonPressed(_:)), for: .touchUpInside)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(filterButton)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            guide.bottomAnchor.constraint(equalTo: filterButton.bottomAnchor),
            guide.bottomAnchor.constraint(equalTo: filterButton.topAnchor, constant: 54)
            ])
        return filterButton
    }
    
}
