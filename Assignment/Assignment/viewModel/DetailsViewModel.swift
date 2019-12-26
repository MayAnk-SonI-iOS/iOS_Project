//
//  DetailsViewModel.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit

class DetailsViewModel: NSObject {
    
    var title:String?
    var description1 : String?
    var imageHref:String?
    
    
    //Dependency Injection
    
    init(detail : DetailsModel){
        self.title = detail.title
        self.description1 = detail.description
        self.imageHref = detail.imageHref
    }
}


