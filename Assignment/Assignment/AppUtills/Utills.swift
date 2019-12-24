//
//  Utills.swift
//  Assignment
//
//  Created by mayank soni on 24/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import Foundation
import Alamofire


func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
}

func isIPad() -> Bool {
       return (UIDevice.current.userInterfaceIdiom == .pad)
   }
