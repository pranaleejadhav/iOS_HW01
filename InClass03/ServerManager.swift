//
//  ServerManager.swift
//  BestBookSeller
//
//  Created by Pranalee Jadhav on 10/23/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import Foundation
import Alamofire


//check internet connectivity
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

let server_url = "http://dev.theappsdr.com/apis/apps.json"

// server call to get data
func getData(onSuccess: @escaping (Any?)-> Void, onFail : @escaping (Error?) ->(Void)){
    
    Alamofire.request(server_url).responseJSON { (response:DataResponse<Any>) in
        
        switch response.result {
        case .success(let value):
            //print(value)
            onSuccess(value)
            
            break
            
        case .failure(let error):
            onFail(error)
            break
        }
    }
    
    
}
