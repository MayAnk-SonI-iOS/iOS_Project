//
//  DetailsViewControllerDataSourceExtension.swift
//  Assignment
//
//  Created by mayank soni on 27/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//


import UIKit

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _DetailsRowVM?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var detailsCell: DetailsCell? = tableView.dequeueReusableCell(withIdentifier: detailsDisplayCell, for: indexPath) as? DetailsCell
        
        if detailsCell == nil {
            detailsCell = DetailsCell.init(style: .default, reuseIdentifier: detailsDisplayCell)
        }
        
        if(_DetailsRowVM != nil){
        detailsCell?.detailsRowViewModel = DetailsRowViewModel.init(pDetailsRowModel: (_DetailsRowVM!.rows[indexPath.row]))
        }
        detailsCell?.layoutIfNeeded()
        detailsCell?.layoutSubviews()
        return detailsCell!
    }
}
