//
//  NewsViewModel.swift
//  WYnews
//
//  Created by intest_zyy on 2018/5/30.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit


class NewsViewModel {
    
    lazy var newsModels : [NewsModel] = [NewsModel]()
    
}

/*
 @escaping  逃逸闭包
 
 在之前，一个函数的参数的闭包的捕捉策略默认是escaping，如果是一个非逃逸闭包需要显示的添加声明@noescape。感兴趣的可以看我以前写过一篇介绍：Swift中被忽略的@noescape。简单的介绍就是如果这个闭包是在这个函数结束前内被调用，就是非逃逸的即noescape。如果这个闭包是在函数执行完后才被调用，调用的地方超过了这函数的范围，所以叫逃逸闭包。
 
 举个例子就是我们常用的masonry或者snapkit的添加约束的方法就是非逃逸的。因为这闭包马上就执行了。
 
 public func snp_makeConstraints(file: String = #file, line: UInt = #line, @noescape closure: (make: ConstraintMaker) -> Void) -> Void {
 ConstraintMaker.makeConstraints(view: self, file: file, line: line, closure: closure)
 }
 网络请求请求结束后的回调的闭包则是逃逸的，因为发起请求后过了一段时间后这个闭包才执行。比如这个Alamofire里的处理返回json的completionHandler闭包，就是逃逸的
 
 */
// MARK:- 发送网络请求
extension NewsViewModel {
    
    func requestData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(URLString: "http://c.m.163.com/nc/article/list/T1348649079062/0-100.html", type: .get) { (result : Any) in
            
            // 1.将Any类型转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            
            // 2.根据T1348649079062的Key取出内容
            guard let dataArray = resultDict["T1348649079062"] as? [[String : Any]] else { return }
            
            // 3.遍历字典,将字典转成模型对象
            for dict in dataArray {
                
                self.newsModels.append(NewsModel.deserialize(from: dict)!)
                
            }
            
            finishCallback()
        }
    }
}
