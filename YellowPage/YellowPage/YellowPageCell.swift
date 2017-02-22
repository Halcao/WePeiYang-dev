//
//  YellowPageCell.swift
//  YellowPage
//
//  Created by Halcao on 2017/2/22.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import UIKit
import SnapKit

// for each item in section
enum YellowPageCellStyle {
    case header
    case section
    case item
}

class YellowPageCell: UITableViewCell {
    
    var canUnfold = true
    var name = ""
    let arrowView = UIImageView()
    var countLabel: UILabel! = nil
    var style: YellowPageCellStyle = .header
    private let bigiPhoneWidth: CGFloat = 414.0
    private let middleiPhoneWidth: CGFloat = 375.0
    private let smalliPhoneWidth: CGFloat = 320.0

    
    convenience init(with style: YellowPageCellStyle, name: String) {
        self.init()
        
        var font: UIFont! = nil
        let width = UIScreen.main.bounds.size.width
        if width >= bigiPhoneWidth { // 414 iPhone 6/7 Plus
            font = UIFont.systemFont(ofSize: 16)
        } else if width >= middleiPhoneWidth { // 375 iPhone 6(S) 7
            font = UIFont.systemFont(ofSize: 15)
        } else if width <= smalliPhoneWidth { // 320 iPhone 5(S)
            font = UIFont.systemFont(ofSize: 14)
        }

        
        self.style = style
        switch style {
        case .header:
            let headerView = CommonView(with: [])
            headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.contentView.addSubview(headerView)
            headerView.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.size.width)
                make.height.equalTo(200)
                make.top.equalTo(contentView)
                make.left.equalTo(contentView)
                make.right.equalTo(contentView)
                make.bottom.equalTo(contentView)
            }
            
        case .section:
            if self.canUnfold {
                arrowView.image = UIImage(named: "ic_arrow_right")
            } else {
                arrowView.image = UIImage(named: "ic_arrow_down")
            }
            arrowView.sizeToFit()
            self.contentView.addSubview(arrowView)
            arrowView.snp.makeConstraints { make in
                make.width.equalTo(15)
                make.height.equalTo(15)
                //make.top.equalTo(contentView).offset(8) //
                make.left.equalTo(contentView).offset(10)
                make.centerY.equalTo(contentView)
                //make.bottom.equalTo(contentView).offset(-8) //
            }
            
            let label = UILabel()
            self.contentView.addSubview(label)
            // TODO: adjust font size
            label.text = name
            label.font = font
            label.sizeToFit()
            label.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(20)
                make.left.equalTo(arrowView.snp.right).offset(10)
                make.centerY.equalTo(contentView)
                make.bottom.equalTo(contentView).offset(-20)
            }

            countLabel = UILabel()
            self.contentView.addSubview(countLabel)
            countLabel.textColor = UIColor.lightGray
            countLabel.font = UIFont.systemFont(ofSize: 14)
            countLabel.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.right).offset(-30)
                make.centerY.equalTo(contentView)
            }
            
        case .item:
            self.textLabel?.text = name
            textLabel?.sizeToFit()
            textLabel?.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(8) //
                make.centerY.equalTo(contentView)
                make.bottom.equalTo(contentView).offset(-8) //
            }
            // TODO: font size
            // layout
        }
        
    }
    
    func tapped(with style: YellowPageCellStyle) {
        switch style {
        case .header:
            break
        case .section:
            // fold & unfold
            self.canUnfold = !self.canUnfold
            if self.canUnfold {
                arrowView.image = UIImage(named: "ic_arrow_down")
                
            } else {
                arrowView.image = UIImage(named: "ic_arrow_right")
            }
        case .item:
            break
        }
    }
    
    
}
