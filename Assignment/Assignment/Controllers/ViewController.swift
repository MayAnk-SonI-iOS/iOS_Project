//
//  ViewController.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit
import PINRemoteImage

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
   
    //Class level variables
    
    var _DetailsVM = [DetailsViewModel]()
    private var _detailsTableView: UITableView!
    
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
        _detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        _detailsTableView.separatorStyle = .none
        
        _detailsTableView.dataSource = self
        _detailsTableView.delegate = self
        _detailsTableView.estimatedRowHeight = 100.0
        _detailsTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(_detailsTableView)
        
        //UITableView Autolayout enable
        _detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        //UITableView Constraints
        _detailsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        _detailsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        _detailsTableView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: barHeight).isActive = true
        _detailsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
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
        mErrorLabel.layer.borderWidth = 0.0
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows in table view
        return _DetailsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create cell
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //title,discription and image is nil blank cell creation
        if(_DetailsVM[indexPath.row].imageHref == "" && _DetailsVM[indexPath.row].title == "" && _DetailsVM[indexPath.row].description1 == ""){
            return cell
        }
        
       //cell properties
        cell.backgroundColor = UIColor.white
        cell.isUserInteractionEnabled = false
     
        //cell base view
        let mBackView : UIView = UIView()
        mBackView.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        mBackView.clipsToBounds = true
        mBackView.layer.cornerRadius = 10.0
        
        cell.addSubview(mBackView)
        mBackView.translatesAutoresizingMaskIntoConstraints = false
        mBackView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant : isIPad() ?  10 : 5).isActive = true
        mBackView.trailingAnchor.constraint(equalTo: cell.trailingAnchor,constant : isIPad() ?  -10 : -5).isActive = true
        mBackView.topAnchor.constraint(equalTo: cell.topAnchor, constant : 5).isActive = true
        mBackView.bottomAnchor.constraint(equalTo: cell.bottomAnchor,constant : -5).isActive = true
       
        //base StackView for data binding
        let mOuterStackView : UIStackView = UIStackView()
        mOuterStackView.axis = .vertical
        mOuterStackView.distribution = .fill
        mOuterStackView.layer.borderWidth = 0.0
        mOuterStackView.spacing = 10
        
        //title label
        let  mTitleLabel : UILabel = UILabel()
        mTitleLabel.text = _DetailsVM[indexPath.row].title
        mTitleLabel.font = UIFont.boldSystemFont(ofSize: isIPad() ? 30 : 20)
        mTitleLabel.textColor = UIColor.black
        mTitleLabel.layer.borderWidth = 0.0
        mTitleLabel.lineBreakMode = .byWordWrapping
        mTitleLabel.numberOfLines = 3
        mTitleLabel.textAlignment = .center
        mTitleLabel.lineBreakMode = .byWordWrapping
        
        //discription label
        let  mDiscriptionLabel  : UILabel = UILabel()
        mDiscriptionLabel.text = _DetailsVM[indexPath.row].description1
        mDiscriptionLabel.layer.borderWidth = 0.0
        mDiscriptionLabel.lineBreakMode = .byWordWrapping
        mDiscriptionLabel.numberOfLines = 0
        mDiscriptionLabel.font = UIFont.systemFont(ofSize: isIPad() ? 25 : 16)
        mDiscriptionLabel.textColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        mDiscriptionLabel.textAlignment = .justified
        
        //Image view
        let mImageView : UIImageView = UIImageView()
        mImageView.contentMode = .scaleAspectFit
     
    //Check for url validation
        if(_DetailsVM[indexPath.row].imageHref != ""){
            let mImageUrl : URL? = URL(string: _DetailsVM[indexPath.row].imageHref!)!
            mImageView.pin_updateWithProgress = true
            mImageView.pin_setPlaceholder(with: UIImage.init(named: "placeholder"))
            if let url : URL = mImageUrl{
                mImageView.pin_setImage(from: url, completion: { (_) in
                })
            }
        }
        
     //Binding wigets in stackview
       mOuterStackView.addArrangedSubview(mTitleLabel)
        mOuterStackView.addArrangedSubview(mDiscriptionLabel)
        mOuterStackView.addArrangedSubview(mImageView)
        
        mImageView.translatesAutoresizingMaskIntoConstraints = false
        mDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        mTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
        
        mTitleLabel.leadingAnchor.constraint(equalTo: mOuterStackView.leadingAnchor).isActive = true
        mTitleLabel.trailingAnchor.constraint(equalTo: mOuterStackView.trailingAnchor).isActive = true
        
        mDiscriptionLabel.leadingAnchor.constraint(equalTo: mOuterStackView.leadingAnchor).isActive = true
        mDiscriptionLabel.trailingAnchor.constraint(equalTo: mOuterStackView.trailingAnchor).isActive = true
        
        
        
        mBackView.addSubview(mOuterStackView)
        mOuterStackView.translatesAutoresizingMaskIntoConstraints = false
        mOuterStackView.leadingAnchor.constraint(equalTo: mBackView.leadingAnchor, constant : 0).isActive = true
        mOuterStackView.trailingAnchor.constraint(equalTo: mBackView.trailingAnchor,constant : isIPad() ?  -10 : -3).isActive = true
        mOuterStackView.topAnchor.constraint(equalTo: mBackView.topAnchor, constant : 5).isActive = true
        mOuterStackView.bottomAnchor.constraint(equalTo: mBackView.bottomAnchor,constant : -5).isActive = true
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cell dinamic height
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    func getData(){
        
        //Progress indicator
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        //API service call
        Service.sharedInstance.getAllData{ (response,error) in
            if(error == nil){
                //response success
                
                self._DetailsVM = response?.map({
                    return DetailsViewModel(detail: $0)
                }) ?? []
                
                //UI Changes on MAin thread
                DispatchQueue.main.async{
                    //Navigation bar
                    let width = self.view.frame.width
                    let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: width, height: 144))
                    self.view.addSubview(navigationBar);
                    let navigationItem = UINavigationItem(title: Service._navTitle)
                    let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: nil, action: #selector(self.refreshView))
                    navigationItem.rightBarButtonItem = doneBtn
                    navigationBar.setItems([navigationItem], animated: false)
                    //TableView Reload
                    self._detailsTableView.reloadData()
                    //Progress indicator removed
                    self.dismiss(animated: false, completion: nil)
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

