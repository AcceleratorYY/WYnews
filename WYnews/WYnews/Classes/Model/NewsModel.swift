//
//  NewsModel.swift
//  WYnews
//
//  Created by coder_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit
import HandyJSON

// 推用荐结构体
struct NewsModel: HandyJSON {
    // MARK: 定义属性
    var replyCount : Int = 0
    var title : String = ""
    var source : String = ""
    var imgsrc : String = ""
}

//class NewsModel: HandyJSON {
//
//    var replyCount : Int = 0
//    var title : String = ""
//    var source : String = ""
//    var imgsrc : String = ""
//    required init() {}
//
//}

// KVC
//class NewsModel: NSObject {
//    // MARK: 定义属性
//    var replyCount : Int = 0
//    var title : String = ""
//    var source : String = ""
//    var imgsrc : String = ""
//
//    // MARK: 定义字典转模型的构造函数
//    init(dict : [String : Any]) {
//        super.init()
//
//        setValuesForKeys(dict)
//    }
//
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
//}

