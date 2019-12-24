//
//  ViewController.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var _DetailsVM = [DetailsViewModel]()
    private var _detailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        if(isConnectedToInternet()){
            tableViewCreator()
        }else{
            errorViewCreator()
        }
    }
    
    func tableViewCreator(){
        getData()
        
        
        
        _detailsTableView = UITableView()
        _detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        _detailsTableView.separatorStyle = .none
        
        _detailsTableView.dataSource = self
        _detailsTableView.delegate = self
        _detailsTableView.estimatedRowHeight = 100.0
        _detailsTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(_detailsTableView)
        _detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        _detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        _detailsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _detailsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        _detailsTableView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: barHeight).isActive = true
        _detailsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    func errorViewCreator(){
        let mErrorView : UIView = UIView()
        mErrorView.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        self.view.addSubview(mErrorView)
        mErrorView.translatesAutoresizingMaskIntoConstraints = false
        
        mErrorView.translatesAutoresizingMaskIntoConstraints = false
        mErrorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mErrorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mErrorView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 0.0).isActive = true
        mErrorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        let mErrorStackView : UIStackView = UIStackView()
        mErrorStackView.axis = .vertical
        // mErrorStackView.distribution = .fillProportionally
        mErrorStackView.spacing = 10
        
        mErrorView.addSubview(mErrorStackView)
        mErrorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mErrorStackView.centerXAnchor.constraint(equalTo: mErrorView.centerXAnchor).isActive = true
        mErrorStackView.centerYAnchor.constraint(equalTo: mErrorView.centerYAnchor).isActive = true
        
        let mErrorLabel : UILabel = UILabel()
        mErrorLabel.text = "No Internet connection.\n Please Tap to Re-try"
        mErrorLabel.textAlignment = .center
        mErrorLabel.layer.borderWidth = 0.0
        mErrorLabel.lineBreakMode = .byWordWrapping
        mErrorLabel.numberOfLines = 2
        
        
        let  mRetryBtn : UIButton = UIButton()
        mRetryBtn.backgroundColor =  UIColor.lightGray
        mRetryBtn.setTitle("Retry", for: .normal)
        mRetryBtn.setTitleColor(UIColor.black, for: .normal)
        mRetryBtn.layer.cornerRadius = 8.0
        mRetryBtn.layer.borderWidth = 2.0
        mRetryBtn.layer.borderColor = UIColor.black.cgColor
        mRetryBtn.addTarget(self, action:  #selector(submitButtonPressed) , for: .touchUpInside)
        
        
        mErrorStackView.addArrangedSubview(mErrorLabel)
        mErrorStackView.addArrangedSubview(mRetryBtn)
        
        mErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        mRetryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        mErrorLabel.leadingAnchor.constraint(equalTo: mErrorStackView.leadingAnchor).isActive = true
        mErrorLabel.trailingAnchor.constraint(equalTo: mErrorStackView.trailingAnchor).isActive = true
        
        mRetryBtn.heightAnchor.constraint(equalToConstant: isIPad() ? 60.0 : 40.0 ).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _DetailsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
        if(isConnectedToInternet()){
            tableViewCreator()
        }else{
            errorViewCreator()
        }
    }
    
    @objc func submitButtonPressed() {
        if(isConnectedToInternet()){
            tableViewCreator()
        }else{
            return
        }
    }
}

