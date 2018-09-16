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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let radius = min(contentView.frame.height, contentView.frame.width) / 2
        contentView.round(corners: [.allCorners], with: radius)
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        contentView.layer.borderWidth = 1
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    
}
