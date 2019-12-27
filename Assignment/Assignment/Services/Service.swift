//
//  Service.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit
import Alamofire

class Service: NSObject {
    
    //Singleton object for Service class
    static let sharedInstance = Service()
    
    static var _navTitle : String = ""
    
    //completion handler
    func getAllData(completion : @escaping(JSResponse?,Error?) ->()){
        //grard protection for application crash
        guard let url = URL(string : mURLString) else{ return }
        
        //API call
        Alamofire.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                
                //Apply string encoding as response is not UTF 8 formatted
                let string = String(decoding: data, as: UTF8.self)
                if let datastr = string.data(using: String.Encoding.utf8) {
                    //Map response data into model
                    do {
                        let response =  try JSONDecoder().decode(JSResponse.self, from: datastr)
                        completion(response,nil)
                    } catch let error as NSError {
                        print(error)
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
