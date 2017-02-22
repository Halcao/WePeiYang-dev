//
//  YellowPageMainViewController.swift
//  YellowPage
//
//  Created by Halcao on 2017/2/22.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import UIKit

class YellowPageMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)

    let sections = PhoneBook.shared.getSections()
    let favorite = PhoneBook.shared.getFavorite()
    
    //var shuldLoadRows: [Int] = []
    var shouldLoadFavorite = false
    var shouldLoadAt = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "黄页";
        // TODO: right button search
        let rightButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if shouldLoadFavorite {
                return favorite.count+1
            } else {
                return 1
            }
        case 2:
            // FIXME: count of data
            if shouldLoadAt >= 0 {
                return PhoneBook.shared.getMembers(with: sections[shouldLoadAt]).count + sections.count
            } else {
                return sections.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = YellowPageCell(with: .header, name: "")
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = YellowPageCell(with: .section, name: "我的收藏")
            // FIXME: DataSource
                cell.countLabel.text = "\(favorite.count)"
                return cell
            } else {
                let cell = YellowPageCell(with: .item, name: favorite[indexPath.row-1])
                return cell
            }
        case 2:
            // FIXME: dataSource
            // FIXME: the following BUGS
            var members: [String] = []
            if shouldLoadAt != -1 {
                members = PhoneBook.shared.getMembers(with: sections[shouldLoadAt])
            }
            
            if indexPath.row > shouldLoadAt && indexPath.row <= shouldLoadAt + members.count && shouldLoadAt != -1 {
                let cell = YellowPageCell(with: .item, name: members[indexPath.row-shouldLoadAt-1])
                return cell
            }
            
            if indexPath.row > members.count + shouldLoadAt && shouldLoadAt != -1 {
                let cell = YellowPageCell(with: .section, name: sections[indexPath.row-members.count])
                cell.countLabel.text = "\(PhoneBook.shared.getMembers(with: sections[indexPath.row-members.count]).count)"
                return cell
            }
            let cell = YellowPageCell(with: .section, name: sections[indexPath.row])
            cell.countLabel.text = "\(PhoneBook.shared.getMembers(with: sections[indexPath.row]).count)"
            return cell

        default:
            // will never be executed
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0: // header: common used
            break
        case 1: // favorite
            // unfold
            let cell = tableView.cellForRow(at: indexPath) as! YellowPageCell
            if cell.style == .section {
                cell.tapped(with: .section)
                shouldLoadFavorite = !shouldLoadFavorite
                tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
            
        case 2: // normal section
            shouldLoadAt = indexPath.row
            //tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.reloadSections(IndexSet(integer: 2), with: .automatic)

            break
        default:
            break
        }
    }
}
