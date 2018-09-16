//
//  MainViewControllerAPIManager.swift
//  Tokopedia Test
//
//  Created by Nayanda Haberty on 16/09/18.
//  Copyright © 2018 Nayanda. All rights reserved.
//

import Foundation
import Eatr

extension MainViewController : EatrDelegate, UIScrollViewDelegate {
    
    func requestForResult(for key : String, with filter: Filter, startIndex : Int, count: Int){
        guard !isRequesting else {
            return
        }
        isRequesting = true
        if startIndex < results.count {
            self.results = Array(self.results.dropLast(results.count - startIndex))
        }
        EatrRequestBuilder.httpGet.set(url: "https://ace.tokopedia.com/search/v2.5/product")
            .addParam(withKey: "q", andValue: key)
            .addParam(withKey: "pmin", andValue: "\(filter.minimumPrice)")
            .addParam(withKey: "pmax", andValue: "\(filter.maximumPrice)")
            .addParam(withKey: "wholesale", andValue: filter.wholeSale ? "true" : "false")
            .addParam(withKey: "official", andValue: filter.officialStore ? "true" : "false")
            .addParam(withKey: "fshop", andValue: filter.goldMerchant ? "2" : "1")
            .addParam(withKey: "start", andValue: "\(startIndex)")
            .set(operationQueue: operationQueue)
            .set(delegate: self)
            .asyncExecute()
    }
    
    // EATR DELEGATE
    
    func eatrOnBeforeSending(_ sessionToSend: URLSession) -> URLSession {
        DispatchQueue.main.async {
            self.showSpinnerForResults()
        }
        return sessionToSend
    }
    
    func eatrOnTimeout() {
        DispatchQueue.main.async {
            self.hideSpinnerForResults()
            self.showAlert(title: "ERROR", message: "SERVER TIMEOUT")
        }
        isRequesting = false
    }
    
    func eatrOnError(_ error: Error) {
        DispatchQueue.main.async {
            self.hideSpinnerForResults()
            self.showAlert(title: "ERROR", message: "FAILED TO GET DATA FROM SERVER")
        }
        isRequesting = false
    }
    
    func eatrOnResponded(_ response: EatrResponse) {
        DispatchQueue.main.async {
            self.hideSpinnerForResults()
        }
        isRequesting = false
        guard let restResponse : RestResponse = response.parsedBody(), let data : [ResultData] = restResponse.data else {
            
            return
        }
        results.append(contentsOf: data)
        DispatchQueue.main.async {
            self.resultCollectionView.reloadData()
        }
    }
    
    // FUNCTION
    
    func showSpinnerForResults(){
        if results.count == 0 {
            blurEffect.frame = resultCollectionView.bounds
            
            bigSpinner.activityIndicatorViewStyle = .whiteLarge
            bigSpinner.startAnimating()
            bigSpinner.frame = resultCollectionView.bounds
            
            resultCollectionView.addSubview(blurEffect)
            resultCollectionView.addSubview(bigSpinner)
        }
        else if let spinnerPosition : SpinnerPosition = spinnerPosition {
            resultCollectionView.showSpinner(on: spinnerPosition)
        }
    }
    
    func hideSpinnerForResults(){
        bigSpinner.stopAnimating()
        bigSpinner.removeFromSuperview()
        blurEffect.removeFromSuperview()
        if let spinnerPosition : SpinnerPosition = spinnerPosition {
            resultCollectionView.hideSpinner(on: spinnerPosition)
        }
    }
    
    public func showAlert(title: String, message: String) -> Void{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.backgroundColor = UIColor.white
        alertController.view.layer.cornerRadius = 18
        blurEffect.frame = view.bounds
        view.addSubview(blurEffect)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {
            _ in
            self.blurEffect.removeFromSuperview()
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
