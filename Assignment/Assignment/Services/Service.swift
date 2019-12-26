//
//  Service.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit


class Service: NSObject {
    
    //Singleton object for Service class
    static let sharedInstance = Service()
    
    static var _navTitle : String = ""
    
    //completion handler
    func getAllData(completion : @escaping([DetailsModel]?,Error?) ->()){
        //grard protection for application crash
        guard let url = URL(string : mURLString) else{ return }
        
        //API call
        URLSession.shared.dataTask(with: url){(data,reponse,error) in
            if let err = error{
                //Error received
                completion(nil,err)
            }else{
                //Sucess
                guard let data = data else{ return }
                do {
                    var mRowdata = [DetailsModel]()
                    //Data to String conversion
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    //String to JSonResponse
                    let response =  try JSONDecoder().decode(JSResponse.self, from: utf8Data!)
                    //Adding data to model
                    for row in response.rows{
                        mRowdata.append(DetailsModel(title: row.title ?? "", description: row.description ?? "", imageHref: row.imageHref  ?? "" ))
                    }
                    Service._navTitle = response.title!
                    completion(mRowdata,nil)
                } catch let jsonErr {
                    //Ecexption handler
                    print("Json Error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
}
