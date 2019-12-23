//
//  ViewController.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var _DetailsVM = [DetailsViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
   getData()
    }

    func getData(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        Service.sharedInstance.getAllData{ (response,error) in
            if(error == nil){
                self._DetailsVM = response?.map({ return DetailsViewModel(detail: $0) }) ?? []
                DispatchQueue.main.async{
                    let width = self.view.frame.width
                    let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: width, height: 144))
                    self.view.addSubview(navigationBar);
                    let navigationItem = UINavigationItem(title: Service._navTitle)
                    let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: nil, action: #selector(self.refreshView))
                    navigationItem.rightBarButtonItem = doneBtn
                    navigationBar.setItems([navigationItem], animated: false)
                  
                    self.dismiss(animated: false, completion: nil)
                }
                print(self._DetailsVM)
            }
            
        }
    }

     @objc func refreshView() {
        getData()
        
    }
}

