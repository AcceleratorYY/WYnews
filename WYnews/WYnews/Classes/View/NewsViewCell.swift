//
//  NewsViewCell.swift
//  WYnews
//
//  Created by coder_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class NewsViewCell: UITableViewCell {
    
    // 纯代码布局打开
    /*
     出代码布局cell
 
    lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        
        return iconImageView
        
        }()
    lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        
        return titleLabel
        
    }()
    lazy var sourceLabel : UILabel = {
        let sourceLabel = UILabel()
        
        return sourceLabel
    }()

    lazy var replyCountLabel : UILabel = {
        let replyCountLabel = UILabel()
        
        return replyCountLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
   */
    
//    // MARK: 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    
    var newsModel : NewsModel? {
        // 监听属性已经发生改变: 已经改变
        didSet {
            titleLabel.text = newsModel?.title
            sourceLabel.text = newsModel?.source
            replyCountLabel.text = "\(newsModel?.replyCount ?? 0)跟帖"

            let iconURL = URL(string: newsModel?.imgsrc ?? "")
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        setUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension NewsViewCell {
    func setUI() {
        
        self.contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        // ... 
        
    }
}


