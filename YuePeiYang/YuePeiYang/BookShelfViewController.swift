//
//  BookShelfViewController.swift
//  YuePeiYang
//
//  Created by Halcao on 2016/10/22.
//  Copyright © 2016年 Halcao. All rights reserved.
//

import UIKit

class BookShelfViewController: UITableViewController {
    
    var bookShelf: [MyBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .None
    }
    
// Mark: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookShelf.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell1")
        cell.textLabel?.text = self.bookShelf[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFontOfSize(13)
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(12)
        cell.detailTextLabel?.text = self.bookShelf[indexPath.row].author + "著"
        //cell.tag = self.bookShelf[indexPath.row].isbn
        var separatorMargin = 20
        // MARK: 这个效果看起来很奇怪
        if indexPath.row == self.bookShelf.count - 1 {
            separatorMargin = 0
        }
            let separator = UIView()
            separator.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 229/255, alpha: 1)
            cell.addSubview(separator)
            
            separator.snp_makeConstraints { make in
                make.height.equalTo(1)
                make.left.equalTo(cell).offset(separatorMargin)
                make.right.equalTo(cell).offset(-separatorMargin)
                make.bottom.equalTo(cell).offset(0)
            }
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.bookShelf.removeAtIndex(indexPath.row)
            User.sharedInstance.bookShelf = self.bookShelf
            // TODO: 删除收藏
            let vc = self.navigationController?.viewControllers[0].childViewControllers[0] as! InfoViewController
            vc.bookShelf = self.bookShelf
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: 跳转到书籍详情页面
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

