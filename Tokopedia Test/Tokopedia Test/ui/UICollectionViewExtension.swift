//
//  UICollectionViewExtension.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import UIKit

fileprivate var spinners : [UICollectionView : [SpinnerPosition : UIView]] = [:]

enum SpinnerPosition {
    case top, bottom
}

extension UICollectionView {
    
    func showSpinner(on position: SpinnerPosition){
        switch position {
        case .top:
            self.contentInset = UIEdgeInsets.init(top: self.contentInset.top + 50, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
            break
        default:
            self.contentInset = UIEdgeInsets.init(top: self.contentInset.top, left: self.contentInset.left, bottom: self.contentInset.bottom + 50, right: self.contentInset.right)
        }
        var spinnerView : UIView?
        if let spView : UIView = self.getSpinner(on: position) {
            spinnerView = spView
        }
        else {
            spinnerView = UIView.init(frame: CGRect.init(x: 0, y: position == .top ? -50 : self.contentSize.height, width: self.frame.width, height: 50))
            let spinner = UIActivityIndicatorView.init(frame: CGRect.init(x: (self.frame.width / 2) - 20, y: 0, width: 40, height: 40))
            spinnerView?.addSubview(spinner)
            spinner.startAnimating()
            spinner.activityIndicatorViewStyle = .gray
        }
        self.addSubview(spinnerView!)
        self.putSpinner(spinnerView!, for: position)
    }
    
    func hideSpinner(on position: SpinnerPosition){
        self.getSpinner(on: position)?.removeFromSuperview()
        switch position {
        case .top:
            if self.spinnerExist(on: position) {
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentInset = UIEdgeInsets.init(top: self.contentInset.top - 50, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
                })
            }
            break
        default:
            if self.spinnerExist(on: position){
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentInset = UIEdgeInsets.init(top: self.contentInset.top, left: self.contentInset.left, bottom: self.contentInset.bottom - 50, right: self.contentInset.right)
                })
            }
        }
        spinners[self]?.removeValue(forKey: position)
    }
    
    fileprivate func spinnerExist(on position: SpinnerPosition) -> Bool {
        let spinnerExist = spinners.contains(where: { (pair) -> Bool in
            return pair.key == self
        })
        if !spinnerExist{
            return false
        }
        return spinners[self]?.contains(where: { (spinnerPair) -> Bool in
            return spinnerPair.key == position
        }) ?? false
    }
    
    fileprivate func putSpinner(_ view: UIView, for position : SpinnerPosition){
        let spinnerExist = spinners.contains(where: { (pair) -> Bool in
            return pair.key == self
        })
        if !spinnerExist{
            spinners[self] = [position : view]
        }
        let spinnerPositionExist = spinners[self]?.contains(where: { (spinnerPair) -> Bool in
            return spinnerPair.key == position
        })
        if let positionExist : Bool = spinnerPositionExist, positionExist, let dic : [SpinnerPosition : UIView] = spinners[self] {
            var dic = dic
            dic[position] = view
            spinners[self] = dic
        }
        else{
            spinners[self] = [ position : view ]
        }
    }
    
    fileprivate func getSpinner(on position: SpinnerPosition) -> UIView? {
        let spinnerExist = spinners.contains(where: { (pair) -> Bool in
            return pair.key == self
        })
        if !spinnerExist{
            return nil
        }
        let spinnerPositionExist = spinners[self]?.contains(where: { (spinnerPair) -> Bool in
            return spinnerPair.key == position
        })
        guard let positionExist : Bool = spinnerPositionExist, positionExist else {
            return nil
        }
        return spinners[self]?[position]
    }
    
}
