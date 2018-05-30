//
//  HomeViewController.swift
//  WYnews
//
//  Created by intest_zyy on 2018/5/24.
//  Copyright © 2018年 coder_zyy. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let kHomeCellID = "kHomeCellID"

// MARK:- 类的声明
class HomeViewController: UIViewController {
    
    // MARK: 懒加载属性
    lazy var newViewModel = NewsViewModel()
    
    fileprivate lazy var tableView : UITableView = {[unowned self] in
        // 1.创建UITableView
        let tableView = UITableView()
        
        // 2.设置tableView相关的属性
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self as UITableViewDelegate
        tableView.rowHeight = 90
        
        // 3.注册Cell
        tableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: kHomeCellID)
        
        return tableView
    }()
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加UITableView
        view.addSubview(tableView)
        
        // 3.请求数据
        loadData()
    }
}


// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupNavigationBar() {
        // 1.设置背景图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "reader_navigation_background"), for: .default)
        
        // 2.设置标题
        navigationItem.titleView = UIImageView(image: UIImage(named: "navigation_logo"))
        
        // 3.设置右侧的搜索按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "navigation_search"), style: .plain, target: self, action: #selector(searchItemClick))
    }
}


// MARK:- 事件监听函数
extension HomeViewController {
    // @objc --> 为了保留OC的特性
    @objc fileprivate func searchItemClick() {
        print("-------")
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.获取Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeCellID, for: indexPath) as! NewsViewCell

        // 2.给Cell设置数据
        cell.newsModel = newViewModel.newsModels[indexPath.row]
        cell.selectionStyle = .default
        return cell
    }
    
    // 代理方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\([indexPath.row])")
        // 取消选中
        tableView .deselectRow(at: indexPath, animated: true)
    }
    // cell 侧滑删除
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 删除样式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            newViewModel.newsModels .remove(at: indexPath.row)
            // 4.刷新表格
            self.tableView.reloadData()
            
        }
    }
    // 修改编辑文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
}

