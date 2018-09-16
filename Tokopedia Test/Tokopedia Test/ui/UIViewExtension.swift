//
//  UIViewExtension.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func round(corners : [UIRectCorner], with radius : CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.masksToBounds = true
        self.layer.mask = mask
    }
}
