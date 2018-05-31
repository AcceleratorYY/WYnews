//
//  NetworkTools.swift
//  WYnews
//
//  Created by coder_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(URLString : String, type : MethodType, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 1.校验是否有结果
            /*
            if let result = response.result.value {
                finishedCallback(result)
            } else  {
                print(response.result.error)
            }
            */
            guard let result = response.result.value else {
                print("erro = ",response.result.error?.localizedDescription as Any)
                return
            }
            if response.result.isFailure {
                return
            }
            finishedCallback(result)
        }
    }
}
