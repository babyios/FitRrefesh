//
//  NormalTableViewController.swift
//  FitRefresh
//
//  Created by Cyrill on 2017/4/28.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class NormalTableViewController: UITableViewController {

    var dataArray: Array<String> = []
    
    // FRNormalCellID
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // target
        self.tableView.fr.headerView = FRNormalHeader(target: self, action: #selector(NormalTableViewController.upPullLoadData))
        self.tableView.fr.headerView?.beginRefreshing()
        
        
//        self.tableView.fr_footerView = FRAutoNormalFooter(target: self, action: #selector(NormalTableViewController.downPullLoadData))
        
        // 闭包方法
        self.tableView.fr.footerView = FRAutoNormalFooter(ComponentRefreshingClosure: {
            self.downPullLoadData()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FRNormalCellID", for: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row]
        
        return cell
    }
    
    @objc func upPullLoadData() {
        
        // 延迟执行 模拟网络延迟，实际开发中去掉
        FRDelay(2) {
            
            for i in 1..<15{
                self.dataArray.append("数据 - \(i + self.dataArray.count)")
            }
            
            self.tableView.reloadData()
            
            self.tableView.fr.footerView?.endRefreshing()
            self.tableView.fr.headerView?.endRefreshing()
            
        }
        
    }
    
    func downPullLoadData() {
        
        // 延迟执行 模拟网络延迟，实际开发中去掉
        FRDelay(2) {
            
            for i in 1..<15{
                self.dataArray.append("数据 - \(i + self.dataArray.count)")
            }
            
            self.tableView.reloadData()
            
            self.tableView.fr.footerView?.endRefreshing()
        }
    }
}
