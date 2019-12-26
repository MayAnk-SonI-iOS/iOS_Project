//
//  Utills.swift
//  Assignment
//
//  Created by mayank soni on 24/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import Foundation
import Alamofire

//Checks internet connectivity on device
func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()!.isReachable
}

//Returns the device type
func isIPad() -> Bool {
    return (UIDevice.current.userInterfaceIdiom == .pad)
}
