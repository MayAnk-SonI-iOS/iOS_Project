//
//  Utills.swift
//  Assignment
//
//  Created by mayank soni on 24/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import Foundation
import Alamofire

//Checks internet connectivity on device
func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
}

//Returns the device type
func isIPad() -> Bool {
    return (UIDevice.current.userInterfaceIdiom == .pad)
}

extension UIViewController {

func showProgressindicator(){
    
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
          let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
          loadingIndicator.hidesWhenStopped = true
          loadingIndicator.style = UIActivityIndicatorView.Style.medium
          loadingIndicator.startAnimating();
          
          alert.view.addSubview(loadingIndicator)
    self.present(alert, animated: true, completion: nil)
        
}

func hideProgressIndecator(){
    self.dismiss(animated: false, completion: nil)
}
    
    func navigationbarintegration(pNavTitle : String){
        let navigationBar: UINavigationBar = UINavigationBar()
                           self.view.addSubview(navigationBar);
                           let navigationItem = UINavigationItem(title: pNavTitle)
                           navigationBar.setItems([navigationItem], animated: false)
                           //Navigation bar autolayout
                           navigationBar.translatesAutoresizingMaskIntoConstraints = false
                           navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                           navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                           navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 40.0).isActive = true
                           navigationBar.heightAnchor.constraint(equalToConstant: 144.0).isActive = true
                 
    }
    
}
