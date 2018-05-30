//
//  NewsViewCell.swift
//  WYnews
//
//  Created by intest_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit
import Kingfisher

class NewsViewCell: UITableViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    
    // MARK: 定义模型属性
    var newsModel : NewsModel? {
        // 监听属性已经发生改变: 已经改变
        didSet {
            // 1.设置基本信息
            titleLabel.text = newsModel?.title
            sourceLabel.text = newsModel?.source
            replyCountLabel.text = "\(newsModel?.replyCount ?? 0)跟帖" // Optional("1234")跟帖
            
            // 2.设置图片
            let iconURL = URL(string: newsModel?.imgsrc ?? "")
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
