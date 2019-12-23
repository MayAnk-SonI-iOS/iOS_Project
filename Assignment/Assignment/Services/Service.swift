//
//  Service.swift
//  Assignment
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import UIKit


class Service: NSObject {

    static let sharedInstance = Service()
    static var _navTitle : String = ""
    func getAllData(completion : @escaping([DetailsModel]?,Error?) ->()){
        let mURLString : String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/dacts.json"
        guard let url = URL(string : mURLString) else{ return }
        URLSession.shared.dataTask(with: url){(data,reponse,error) in
            if let err = error{
                completion(nil,err)
                print("Error : \(err.localizedDescription)")
            }else{
                guard let data = data else{ return }
                do {
                    var mRowdata = [DetailsModel]()
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    let response =  try JSONDecoder().decode(JSResponse.self, from: utf8Data!)
                    for row in response.rows{
                        mRowdata.append(DetailsModel(title: row.title ?? "", description: row.description ?? "", imageHref: row.imageHref  ?? "" ))
                    }
                    Service._navTitle = response.title!
                    completion(mRowdata,nil)
                } catch let jsonErr {
                    print("Json Error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
}
