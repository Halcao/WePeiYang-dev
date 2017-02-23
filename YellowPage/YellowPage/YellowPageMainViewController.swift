//
//  YellowPageMainViewController.swift
//  YellowPage
//
//  Created by Halcao on 2017/2/22.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import UIKit

class YellowPageMainViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)

    let sections = PhoneBook.shared.getSections()
    let favorite = PhoneBook.shared.getFavorite()
    
    var shouldLoadSections: [Int] = [] // contains each section which should be loaded
    var shouldLoadFavorite = false

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
    
}

// MARK: UITableViewDataSource
extension YellowPageMainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + sections.count
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
        case let section where section > 1 && section < 2+sections.count:
            let n = section - 2
            if shouldLoadSections.contains(n) {
                return PhoneBook.shared.getMembers(with: sections[n]).count+1
            } else {
                return 1
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
                cell.canUnfold = !shouldLoadFavorite
                cell.countLabel.text = "\(favorite.count)"
                return cell
            } else {
                let cell = YellowPageCell(with: .item, name: favorite[indexPath.row-1])
                return cell
            }
        case let section where section > 1 && section < 2+sections.count:
            // FIXME: dataSource
            // index in sections: [String]
            
            let n = indexPath.section - 2
            let members = PhoneBook.shared.getMembers(with: sections[n])
            
            if indexPath.row == 0 {
                let cell = YellowPageCell(with: .section, name: sections[n])
                cell.countLabel.text = "\(members.count)"
                if shouldLoadSections.contains(n) {
                    cell.canUnfold = false
                } else {
                    cell.canUnfold = true
                }
                return cell
            } else {
                if shouldLoadSections.contains(n) {
                    let cell = YellowPageCell(with: .item, name: members[indexPath.row-1])
                    return cell
                }
            }
            let cell = UITableViewCell()
            return cell
        default:
            // will never be executed
            let cell = UITableViewCell()
            return cell
        }
    }
}


// MARK: UITableViewDelegate
extension YellowPageMainViewController: UITableViewDelegate {
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
            
        case let section where section > 1 && section < 2+sections.count: //  section
            let n = indexPath.section - 2
            if shouldLoadSections.contains(n) {
               shouldLoadSections = shouldLoadSections.filter { e in
                    return e != n
                }
            } else {
                shouldLoadSections.append(n)
            }
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            break
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            // don't know why i can't just return 0
            return 0.001
        } else if section < 3 {
            return 7
        } else {
            // return 0
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < 2 {
            return 7
        } else {
            return 0.001
        }
    }
}
