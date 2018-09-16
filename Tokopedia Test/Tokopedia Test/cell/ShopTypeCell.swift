//
//  ShopTypeCell.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class ShopTypeCell : UICollectionViewCell {
    
    var label : UILabel!
    var circle : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assemblyCell(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    func apply(color : UIColor){
        label.textColor = color.withAlphaComponent(0.7)
        circle.layer.borderColor = color.withAlphaComponent(0.5).cgColor
        circle.backgroundColor = color.withAlphaComponent(0.15)
        contentView.layer.borderColor = color.withAlphaComponent(0.7).cgColor
    }
    
    fileprivate func assemblyCell(_ frame : CGRect){
        let radius = contentView.frame.height / 2
        contentView.round(corners: [.allCorners], with: radius)
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = radius
        contentView.backgroundColor = UIColor.clear
        
        circle = UIView.init(frame: CGRect.init(x: frame.width - frame.height, y: 0, width: frame.height, height: frame.height))
        circle.round(corners: [.allCorners], with: radius)
        circle.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        circle.layer.borderWidth = 1
        circle.layer.cornerRadius = radius
        circle.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        contentView.addSubview(circle)
        
        let cross = UIImageView.init(image: #imageLiteral(resourceName: "ic_cancel"))
        cross.alpha = 0.25
        let crossMargin : CGFloat = 10
        cross.frame = CGRect.init(x: crossMargin, y: crossMargin, width: circle.frame.width - (crossMargin * 2), height: circle.frame.height - (crossMargin * 2))
        circle.addSubview(cross)
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
}
