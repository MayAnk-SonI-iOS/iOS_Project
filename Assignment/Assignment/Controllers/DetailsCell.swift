//
//  DetailsCell.swift
//  Assignment
//
//  Created by mayank soni on 27/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//


import UIKit

class DetailsCell: UITableViewCell {
    
    let  mTitleLabel : UILabel = UILabel()
    let  mDiscriptionLabel  : UILabel = UILabel()
    let mImageView : UIImageView = UIImageView()
    
    var detailsRowViewModel: DetailsRowViewModel? {
        didSet {
            mTitleLabel.text =  detailsRowViewModel?.title
            mDiscriptionLabel.text = detailsRowViewModel?.desctiption
            mImageView.pin_updateWithProgress = true
            mImageView.pin_setPlaceholder(with: UIImage.init(named: "placeholder"))
            if let url = detailsRowViewModel?.imageHrefUrl {
                mImageView.pin_setImage(from: url, completion: { (_) in
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        //cell base view
        let mBackView : UIView = UIView()
        mBackView.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        mBackView.clipsToBounds = true
        mBackView.layer.cornerRadius = 10.0
        
        contentView.addSubview(mBackView)
        mBackView.translatesAutoresizingMaskIntoConstraints = false
        mBackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant : isIPad() ?  10 : 5).isActive = true
        mBackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant : isIPad() ?  -10 : -5).isActive = true
        mBackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant : 5).isActive = true
        mBackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant : -5).isActive = true
        
        //base StackView for data binding
        let mOuterStackView : UIStackView = UIStackView()
        mOuterStackView.axis = .vertical
        mOuterStackView.distribution = .fillProportionally
        mOuterStackView.spacing = 10
        
        //title label
        mTitleLabel.font = UIFont.boldSystemFont(ofSize: isIPad() ? 30 : 20)
        mTitleLabel.textColor = UIColor.black
        mTitleLabel.lineBreakMode = .byWordWrapping
        mTitleLabel.numberOfLines = 3
        mTitleLabel.textAlignment = .center
        mTitleLabel.lineBreakMode = .byWordWrapping
        
        //discription label
        mDiscriptionLabel.lineBreakMode = .byWordWrapping
        mDiscriptionLabel.numberOfLines = 0
        mDiscriptionLabel.font = UIFont.systemFont(ofSize: isIPad() ? 25 : 16)
        mDiscriptionLabel.textColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        mDiscriptionLabel.textAlignment = .justified
        
        
        mImageView.contentMode = .scaleAspectFit
        //Binding wigets in stackview
        mOuterStackView.addArrangedSubview(mTitleLabel)
        mOuterStackView.addArrangedSubview(mDiscriptionLabel)
        mOuterStackView.addArrangedSubview(mImageView)
        mDiscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        mTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mImageView.translatesAutoresizingMaskIntoConstraints = false
        
        mTitleLabel.leadingAnchor.constraint(equalTo: mOuterStackView.leadingAnchor).isActive = true
        mTitleLabel.trailingAnchor.constraint(equalTo: mOuterStackView.trailingAnchor).isActive = true
        
        mDiscriptionLabel.leadingAnchor.constraint(equalTo: mOuterStackView.leadingAnchor).isActive = true
        mDiscriptionLabel.trailingAnchor.constraint(equalTo: mOuterStackView.trailingAnchor).isActive = true
        
        mImageView.heightAnchor.constraint(lessThanOrEqualToConstant: isIPad() ? 250.0 : 180).isActive = true
        mImageView.widthAnchor.constraint(lessThanOrEqualToConstant: isIPad() ? 250.0 : 180).isActive = true
        
        mBackView.addSubview(mOuterStackView)
        mOuterStackView.translatesAutoresizingMaskIntoConstraints = false
        mOuterStackView.leadingAnchor.constraint(equalTo: mBackView.leadingAnchor, constant : 0).isActive = true
        mOuterStackView.trailingAnchor.constraint(equalTo: mBackView.trailingAnchor,constant : isIPad() ?  -10 : -3).isActive = true
        mOuterStackView.topAnchor.constraint(equalTo: mBackView.topAnchor, constant : 5).isActive = true
        mOuterStackView.bottomAnchor.constraint(equalTo: mBackView.bottomAnchor,constant : -5).isActive = true
      
    }
    
    
}
