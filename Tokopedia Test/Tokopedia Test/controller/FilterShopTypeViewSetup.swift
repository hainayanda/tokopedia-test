//
//  FilterShopTypeViewSetup.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

extension FilterViewController {
    
    func setupShopType(topAnchorConstraint topAnchor : NSLayoutYAxisAnchor, margin : CGFloat, goToShopType handler : Selector) -> UICollectionView {
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
            viewCard.topAnchor.constraint(equalTo: topAnchor),
            viewCard.heightAnchor.constraint(equalToConstant: 120)
            ])
        
        let label = UILabel()
        label.text = "Shop Type"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        viewCard.addSubview(label)
        
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ic_go"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: handler, for: .touchUpInside)
        viewCard.addSubview(button)
        self.view.sendSubview(toBack: viewCard)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: margin),
            label.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: margin),
            viewCard.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 30)
            ])
        return setupShopTypeButton(in: viewCard, with: button.bottomAnchor, 15)
    }
    
    func setupShopTypeButton(in containerView : UIView, with topAnchor : NSLayoutYAxisAnchor, _ margin : CGFloat) -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize.init(width: 145, height: 36)
        flowLayout.minimumLineSpacing = 9
        flowLayout.minimumInteritemSpacing = 9
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.register(ShopTypeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: margin)
            ])
        
        return collectionView
    }
}
