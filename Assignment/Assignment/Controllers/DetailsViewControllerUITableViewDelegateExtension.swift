//
//  DetailsViewControllerUITableViewDelegateExtension.swift
//  Assignment
//
//  Created by mayank soni on 27/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//




import UIKit

extension UIViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 65
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
