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
            viewCard.heightAnchor.constraint(equalToConstant: 150)
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
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: margin),
            label.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: margin),
            viewCard.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 30)
            ])
        return setupShopTypeButton(in: viewCard)
    }
    
    func setupShopTypeButton(in containerView : UIView) -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize.init(width: 180, height: 45)
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView.init(frame: containerView.bounds, collectionViewLayout: flowLayout)
        
        return collectionView
    }
}
