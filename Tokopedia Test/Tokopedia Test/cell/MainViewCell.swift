//
//  MainCellView.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

class MainViewCell : UICollectionViewCell {
    
    // UI COMPONENT
    var picture : UIImageView!
    var itemName : UILabel!
    var itemPrice : UILabel!
    
    // DATA
    var data : ResultData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assemblyCell(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func apply(with data : ResultData){
        self.data = data
        itemPrice.text = data.price ?? "Rp 0"
        itemName.text = data.name
        picture.image = nil
        guard let imageUri : String = data.image_uri else {
            return
        }
        PictureManager.sharedInstance.getImage(key: "\(data.id ?? 0)", imageUri) { (image) in
            DispatchQueue.main.async {
                guard let image : UIImage = image else {
                    self.picture.image = nil
                    return
                }
                self.picture.image = image
            }
        }
    }
    
    fileprivate func assemblyCell(_ frame : CGRect){
        self.contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        self.contentView.layer.borderWidth = 0.5
        self.contentView.backgroundColor = #colorLiteral(red: 0.9741632297, green: 0.9741632297, blue: 0.9741632297, alpha: 1)
        picture = UIImageView()
        picture.backgroundColor = UIColor.gray
        picture.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(picture)
        
        itemName = UILabel()
        itemName.numberOfLines = 2
        itemName.font = UIFont.systemFont(ofSize: 14)
        itemName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(itemName)
        
        itemPrice = UILabel()
        itemPrice.font = UIFont.systemFont(ofSize: 14)
        itemPrice.textColor = #colorLiteral(red: 1, green: 0.3411764706, blue: 0.1333333333, alpha: 1)
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(itemPrice)
        NSLayoutConstraint.activate([
            picture.widthAnchor.constraint(equalToConstant: frame.width - 24),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: 1),
            picture.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            picture.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant : 12),
            itemName.topAnchor.constraint(equalTo: picture.bottomAnchor, constant : 12),
            itemName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant : 12),
            self.contentView.trailingAnchor.constraint(equalTo: itemName.trailingAnchor, constant: 12),
            self.bottomAnchor.constraint(equalTo: itemPrice.bottomAnchor, constant : 18),
            itemPrice.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant : 12),
            self.contentView.trailingAnchor.constraint(equalTo: itemPrice.trailingAnchor, constant: 12),
            ])
    }
    
}
