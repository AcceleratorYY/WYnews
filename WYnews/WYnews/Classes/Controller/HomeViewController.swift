//
//  HomeViewController.swift
//  WYnews
//
//  Created by coder_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit

private let kHomeCellID = "kHomeCellID"

class HomeViewController: UIViewController {
    fileprivate var dataCount: Int = 10
    var refreshCtl:TGRefreshSwift?//高级用法时这行可以去掉
    fileprivate var isPullUp = false
    lazy var footIndicatorView: TGIndicatorView = {
        let indicator = TGIndicatorView(frame:CGRect(x: 0, y: 0, width: 20, height: 20),
                                        type:.lineScalePulseOut)
        indicator.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        return indicator
    }()
    
    lazy var newViewModel = NewsViewModel()
    
    fileprivate lazy var tableView : UITableView = {[unowned self] in
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: (SCREEN_HEIGHT == 812 ? 88 : 64), width: self.view.bounds.width, height: self.view.bounds.height - ((SCREEN_HEIGHT == 812 ? 88 : 64)))
        tableView.dataSource = self
        tableView.delegate = self as UITableViewDelegate
//        tableView.rowHeight = 90
//        tableView.register(NewsViewCell.self, forCellReuseIdentifier:kHomeCellID)
        tableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: kHomeCellID)
        
        return tableView
    }()
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        view.addSubview(tableView)
        self.automaticallyAdjustsScrollViewInsets=false
        tableView.tableFooterView = footIndicatorView
        
        // 开始刷新
        //最优推荐用法
        builderRecommend4()

    }
}

extension HomeViewController {
    
    fileprivate func builderRecommend4(){
        
        self.tableView.tg_header = TGRefreshSwift.refresh(self, #selector(begainloadData)){(refresh) in
            refresh.tg_refreshResultBgColor(UIColor.red)
                .tg_kind(.Common)
                .tg_tinColor(UIColor.red)
                .tg_fadeinTime(1)
                .tg_fadeoutTime(1)
                .tg_verticalAlignment(.Midden)
                .tg_indicatorRefreshingStyle(.lineCursor)
                .tg_indicatorNormalStyle(.lineOrderbyAsc)
                .tg_bgColor(UIColor(white:1,alpha:1))
        }
        self.tableView.tg_header?.beginRefreshing()
    }
    
    //扩展用法
    fileprivate func builderRecommend5(){
        self.tableView.tg_header = TGRefreshSwift.refresh(self, #selector(loadDataSenior),44,UIImageView(image: UIImage(named: "")) ){(refresh) in
            refresh.tg_refreshResultBgColor(UIColor.orange.withAlphaComponent(0.8))
                .tg_verticalAlignment(.Midden)
                .tg_tinColor(UIColor.white)
                .tg_tipLabelFontSize(12)
                .tg_resultLabelFontSize(13)
                .tg_tipFailStyle(.ballScale)
                .tg_tipOKStyle(.ballScale)
                .tg_indicatorRefreshingStyle(.orbit)
                .tg_fadeinTime(1)
                .tg_fadeoutTime(0.5)
                .tg_bgColor(UIColor(white:0.5,alpha:1))
        }
        self.tableView.tg_header?.beginRefreshing()
    }
}

extension HomeViewController {
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "reader_navigation_background"), for: .default)
        navigationItem.titleView = UIImageView(image: UIImage(named: "navigation_logo"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "navigation_search"), style: .plain, target: self, action: #selector(searchItemClick))
    }
}

extension HomeViewController {
    @objc fileprivate func searchItemClick() {
        print("searchItemClick")
    }
    
// MARK:- 下拉刷新
    @objc fileprivate func begainloadData() {
        print("loadDataSenior")
        
        // 加载数据
        loadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {

            let isSuccess = self.newViewModel.newsModels.count % 2 == 0
            let count = isSuccess ? 10 + 0 : 0
            self.isPullUp ? (self.dataCount += Int(count)) : (self.dataCount = count>0 ? Int(count) : self.dataCount)
            !self.isPullUp ? self.tableView.tg_header?.refreshResultStr = count>0 ? "成功为您推荐\(count)条新内容" : "" : ()
            !self.isPullUp ? self.tableView.tg_header?.isSuccess = isSuccess : ()
            isSuccess ? self.tableView.reloadData() : ()
            !self.isPullUp ? self.tableView.tg_header?.endRefreshing() : ()
            self.isPullUp ? self.footIndicatorView.stopAnimating() : ()
            self.isPullUp = false//恢复标记
        }
    }
    
    @objc fileprivate func loadDataSenior() {
        // 加载更多数据
        loadMoreData()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            let isSuccess = self.newViewModel.newsModels.count % 2 == 0
            let count = isSuccess ? 10 + 0 : 0
            self.isPullUp ? (self.dataCount += Int(count)) : (self.dataCount = count>0 ? Int(count) : self.dataCount)
            !self.isPullUp ? self.tableView.tg_header?.refreshResultStr = count>0 ? "成功为您推荐\(count)条新内容" : "" : ()
            !self.isPullUp ? self.tableView.tg_header?.isSuccess = isSuccess : ()
            isSuccess ? self.tableView.reloadData() : ()
            !self.isPullUp ? self.tableView.tg_header?.endRefreshing() : ()
            self.isPullUp ? self.footIndicatorView.stopAnimating() : ()
            self.isPullUp = false//恢复标记
        }
        
    }
}

// MARK:- 网络数据的请求
extension HomeViewController {
    fileprivate func loadData() {
        // 请求数据
        newViewModel.requestData({
            // 刷新表格
            self.tableView.reloadData()

        })
    }
    fileprivate func loadMoreData() {
        newViewModel.requestData({
            self.tableView.reloadData()
            
        })
    }
}

// MARK:- 实现UITableView的数据源和代理方法
// 遵守数据源协议、遵守代理协议
extension HomeViewController : UITableViewDataSource , UITableViewDelegate {
    // 数据源方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newViewModel.newsModels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeCellID, for: indexPath) as! NewsViewCell
        cell.newsModel = newViewModel.newsModels[indexPath.row]
        cell.selectionStyle = .default
        return cell
    }
    
    // 代理方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\([indexPath.row])")
        tableView .deselectRow(at: indexPath, animated: true)
    }
    // cell 侧滑删除
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            newViewModel.newsModels .remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
// MARK:- 上拉加载更多
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 &&
            scrollView.contentSize.height - self.tableView.frame.size.height - scrollView.contentOffset.y <= 0 &&
            !isPullUp &&
            !footIndicatorView.isAnimating{
            footIndicatorView.color = TGRefreshSwift.randomColor()
            footIndicatorView.type = TGIndicatorType(rawValue: Int(arc4random_uniform(UInt32(TGIndicatorType.allTypes.count - 1))) + 1)!
            footIndicatorView.startAnimating()
            isPullUp = true
            loadDataSenior()
        }
    }
    
    
}

