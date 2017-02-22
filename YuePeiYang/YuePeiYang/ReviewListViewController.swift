//
//  ReviewListViewController.swift
//  YuePeiYang
//
//  Created by Halcao on 2016/10/23.
//  Copyright © 2016年 Halcao. All rights reserved.
//

import UIKit

class ReviewListViewController: UITableViewController {
    
    var reviewArr: [MyReview] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的评论"
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 130
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .None

    }
    
    // Mark: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ReviewCell(model: self.reviewArr[indexPath.row])
        // TODO: 头像
        cell.username.text = "这里是用户名"
        cell.avatar.image = UIImage(named: "avatar")
        if indexPath.row == reviewArr.count - 1 {
            cell.separator.removeFromSuperview()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: 跳转到书籍详情页面
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}