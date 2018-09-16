//
//  ShopTypeCell.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton

class ShopTypeRadioButtonCell : UITableViewCell {
    
    //UI COMPONENT
    
    var radioButton : DLRadioButton!
    var label : UILabel!
    
    // OVERRIDE
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        radioButton = DLRadioButton(type: .contactAdd)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.isIconSquare = true
        radioButton.tintColor = #colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1)
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(radioButton)
        self.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 12),
            contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 12)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
