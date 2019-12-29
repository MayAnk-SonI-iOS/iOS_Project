//
//  ViewController.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit
import PINRemoteImage
import SDWebImage

class ViewController: UIViewController{
    
    //Class level variables
    private var _detailsTableView: UITableView!
    var refreshControl: UIRefreshControl?
    
    var _DetailsVM :DetailsViewModel?
    
    var _DetailsRowVM : DetailsViewModel?
    var _detailsModel : JSResponse?{
        
        didSet {
            guard let _detailsModel = _detailsModel else { return }
            _DetailsRowVM = DetailsViewModel.init(pJsonResponse: _detailsModel)
            DispatchQueue.main.async {
                self._detailsTableView.reloadData()
            }
        }
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            //Base view color
            self.view.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    
            //Internet connection check
            if(isConnectedToInternet()){
                tableViewCreator()
            }else{
                errorViewCreator()
            }
        }
    

    func tableViewCreator(){
        
        // API call
        getData()
        
        // UITable View
        _detailsTableView = UITableView()
        _detailsTableView?.register(DetailsCell.self, forCellReuseIdentifier: "cell")
        _detailsTableView?.accessibilityIdentifier = "Details_TableView"
        _detailsTableView.separatorStyle = .none
        
        _detailsTableView?.delegate = self
        _detailsTableView?.dataSource = self
        
        _detailsTableView.estimatedRowHeight = 100.0
        _detailsTableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(_detailsTableView)
        
        //UITableView Autolayout enable
        _detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        //UITableView Constraints
        _detailsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _detailsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        _detailsTableView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: barHeight).isActive = true
        _detailsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        self.refreshControl = UIRefreshControl.init()
        self.refreshControl?.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        self._detailsTableView?.addSubview(refreshControl!)
        self._detailsTableView?.allowsSelection = false
    }
    
    func errorViewCreator(){
        //If network not available this function will create view
        let mErrorView : UIView = UIView()
        mErrorView.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        self.view.addSubview(mErrorView)
        mErrorView.translatesAutoresizingMaskIntoConstraints = false
        
        mErrorView.translatesAutoresizingMaskIntoConstraints = false
        mErrorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mErrorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mErrorView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 0.0).isActive = true
        mErrorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        //StackView for elements binding
        let mErrorStackView : UIStackView = UIStackView()
        mErrorStackView.axis = .vertical
        mErrorStackView.spacing = 10
        
        mErrorView.addSubview(mErrorStackView)
        mErrorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mErrorStackView.centerXAnchor.constraint(equalTo: mErrorView.centerXAnchor).isActive = true
        mErrorStackView.centerYAnchor.constraint(equalTo: mErrorView.centerYAnchor).isActive = true
        
        //Error message label
        let mErrorLabel : UILabel = UILabel()
        mErrorLabel.text = "No Internet connection.\n Please Tap to Re-try"
        mErrorLabel.textAlignment = .center
        mErrorLabel.lineBreakMode = .byWordWrapping
        mErrorLabel.numberOfLines = 2
        
        //Retry Button
        let  mRetryBtn : UIButton = UIButton()
        mRetryBtn.backgroundColor =  UIColor.lightGray
        mRetryBtn.setTitle("Retry", for: .normal)
        mRetryBtn.setTitleColor(UIColor.black, for: .normal)
        mRetryBtn.layer.cornerRadius = 8.0
        mRetryBtn.layer.borderWidth = 2.0
        mRetryBtn.layer.borderColor = UIColor.black.cgColor
        mRetryBtn.addTarget(self, action:  #selector(retryButtonPressed) , for: .touchUpInside)
        
        
        mErrorStackView.addArrangedSubview(mErrorLabel)
        mErrorStackView.addArrangedSubview(mRetryBtn)
        
        mErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        mRetryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        mErrorLabel.leadingAnchor.constraint(equalTo: mErrorStackView.leadingAnchor).isActive = true
        mErrorLabel.trailingAnchor.constraint(equalTo: mErrorStackView.trailingAnchor).isActive = true
        
        mRetryBtn.heightAnchor.constraint(equalToConstant: isIPad() ? 60.0 : 40.0 ).isActive = true
        
    }
    
    func getData(){
        
        //Progress indicator
        showProgressindicator()
        //API service call
        Service.sharedInstance.getAllData{ (response,error) in
            if(error == nil){
                
                self._detailsModel = response
                
                //UI Changes on MAin thread
                DispatchQueue.main.async{
                    //Navigation bar
                    self.navigationbarintegration(pNavTitle : response!.title!)
                    //TableView Reload
                    self._detailsTableView.reloadData()
                    //Progress indicator removed
                    self.hideProgressIndecator()
                }
            }
            
        }
    }
    
    @objc func refreshView() {
        //Refresh button taped
        if(isConnectedToInternet()){
            tableViewCreator()
        }else{
            errorViewCreator()
        }
    }
    
    @objc func retryButtonPressed() {
        //Retry button taped
        if(isConnectedToInternet()){
            tableViewCreator()
        }else{
            return
        }
    }
}

