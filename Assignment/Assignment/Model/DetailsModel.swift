//
//  DetailsModel.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit


class DetailsModel: Decodable {
    
    var title:String?
    var description:String?
    var imageHref:String?
    
     init(title : String,description : String,imageHref : String) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }

}

class JSResponse: Decodable {

    var title : String?
    var rows:[DetailsModel]
    
     init(title : String,rows : [DetailsModel]) {
        self.title = title
        self.rows = rows
    }
    
    
}

