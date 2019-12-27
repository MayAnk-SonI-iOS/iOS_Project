//
//  DetailsViewModel.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit

class DetailsViewModel: NSObject {
    var detailsModel: JSResponse?
        
        var title: String {
            return detailsModel?.title ?? "Title not available"
        }
        
        var rows: [DetailsModel] {
            
            return detailsModel?.rows ?? []
        }
        
        init(pJsonResponse: JSResponse) {
            self.detailsModel = pJsonResponse
        }
    }





class DetailsRowViewModel: NSObject {
    var mDetailsRowModel: DetailsModel?
    
    var title: String {
        return mDetailsRowModel?.title ?? "No Title Available"
    }
    
    var desctiption: String {
        return mDetailsRowModel?.description ?? "Description not available"
    }
    
    var imageHrefUrl: URL? {
        if let imgHrefUrl = mDetailsRowModel?.imageHref {
            // To convert string into URL
            if let url = URL.init(string: imgHrefUrl) {
                return url
            }
        }
        return nil
    }

    init(pDetailsRowModel: DetailsModel) {
        self.mDetailsRowModel = pDetailsRowModel
    }
}
