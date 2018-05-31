//
//  NewsViewModel.swift
//  WYnews
//
//  Created by coder_zyy on 2018/5/30.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit

class NewsViewModel {
    lazy var newsModels : [NewsModel] = [NewsModel]()
}
// MARK:- 发送网络请求
extension NewsViewModel {
    // http://c.m.163.com/nc/article/list/T1348649079062/0-20.html"
    func requestData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://c.m.163.com/nc/article/list/T1348649079062/0-10.html", type: .get) { (result : Any) in
            
            guard let resultDict = result as? [String : Any] else { return }
//            print("resultDict = ",resultDict.description)
            
            guard let dataArray = resultDict["T1348649079062"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                
                self.newsModels.append(NewsModel.deserialize(from: dict)!)
                
            }
            
            finishCallback()
        }
    }
}
