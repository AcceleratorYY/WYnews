//
//  NetworkTools.swift
//  WYnews
//
//  Created by intest_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    
    
    class func requestData(URLStr : String ,type : MethodType , parameters : [String : Any]?  = nil , finishedCallback : @escaping (_ result : Any) -> ()){
        
        let method = type == .get ?HTTPMethod.get :HTTPMethod.post
        
        Alamofire.request(URLStr, method: method, parameters:parameters ).responseJSON { (response) in
            
            // 1.校验是否有结果
            guard let Result = response.result.value else{
                // 有错误
                print(response.result.error as Any)
                return
            }
            // 2.返回结果
            finishedCallback(Result)
        }
    
        
    }
    
}
