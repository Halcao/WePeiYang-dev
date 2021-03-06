
//
//  Review.swift
//  CellAutolayout
//
//  Created by Halcao on 2016/10/24.
//  Copyright © 2016年 Halcao. All rights reserved.
//

import UIKit
import SnapKit

class ReviewCell: UITableViewCell {
    var avatar: UIImageView = UIImageView()
    var content: UILabel = UILabel()
    var username: UILabel = UILabel()
    var rateView: RateStarView = RateStarView()
    var timestamp: UILabel = UILabel()
    var heartView: UIImageView = UIImageView()
    var like: UILabel = UILabel()
    let separator = UIView()
    
    private let bigiPhoneWidth: CGFloat = 414.0
    private let kAVATAR_HEIGHT = 45
    
    convenience init(model: MyReview) {
        self.init()
        self.content.text = model.content
        // TODO: 头像
        self.like.text = String(format: "%02d", model.like)
        // TODO: TimeStamp
        self.timestamp.text = model.timestamp
        self.rateView.count = model.rate
        // TODO: 用户名
        // self.username.text =
        
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(content)
        self.contentView.addSubview(username)
        self.contentView.addSubview(rateView)
        self.contentView.addSubview(timestamp)
        self.contentView.addSubview(heartView)
        self.contentView.addSubview(like)
        self.contentView.addSubview(separator)
        
        // let frame = avatar.frame
        // avatar.frame = CGRectMake(frame.origin.x, frame.origin.y, 45, 45)
        avatar.snp_makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(15)
            make.height.equalTo(kAVATAR_HEIGHT)
            make.width.equalTo(kAVATAR_HEIGHT)
        }

        avatar.layer.cornerRadius = CGFloat(kAVATAR_HEIGHT/2)
        avatar.layer.masksToBounds = true
        
        username.font = UIFont.systemFontOfSize(14)
        username.textColor = UIColor.init(red: 151/255, green: 152/255, blue: 153/255, alpha: 1)
        username.sizeToFit()
        username.snp_makeConstraints { make in
            make.left.equalTo(avatar.snp_right).offset(10)
            make.top.equalTo(contentView).offset(15)
        }
        
        rateView.snp_makeConstraints { make in
          //  make.width.equalTo(120)
          //  make.height.equalTo(20)
            make.top.equalTo(username.snp_bottom).offset(3)
            make.left.equalTo(avatar.snp_right).offset(10)
        }
        
        let width = UIScreen.mainScreen().bounds.size.width
        
        if width > bigiPhoneWidth {
            content.font = UIFont.systemFontOfSize(16)
        } else {
            content.font = UIFont.systemFontOfSize(14)
        }
        
        content.preferredMaxLayoutWidth = width - 40;
        content.lineBreakMode = NSLineBreakMode.ByWordWrapping
        // content.font = UIFont.systemFontOfSize(16)
        content.numberOfLines = 0
        content.textColor = UIColor(red:0, green:0, blue:0, alpha:0.8)
        content.sizeToFit()
        content.snp_makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(avatar.snp_bottom).offset(10)
            make.right.equalTo(contentView).offset(-20)
        }
                
        timestamp.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        timestamp.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        timestamp.sizeToFit()
        timestamp.snp_makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(content.snp_bottom).offset(10)
            make.bottom.equalTo(contentView).offset(-20)
        }
        
        like.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
        like.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        like.snp_makeConstraints { make in
            make.right.equalTo(contentView).offset(-30)
            make.bottom.equalTo(contentView).offset(-20)
        }
        
        heartView.image = UIImage(named: "grey_heart")
        heartView.snp_makeConstraints { make in
            make.right.equalTo(like.snp_left).offset(-3)
           // make.top.equalTo(contentView).offset(16)
            make.centerY.equalTo(like.snp_centerY)
            //make.height.equalTo(14)
            //make.width.equalTo(15)
            make.height.equalTo(12)
            make.width.equalTo(13)
        }
        
        
        separator.backgroundColor = UIColor.init(red: 227/255, green: 227/255, blue: 229/255, alpha: 1)
        separator.snp_makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(0)
        }
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class RateStarView: UIView {
    var imgArr: [UIImageView] = []
    var count = 3{
        didSet{
            refreshView()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        refreshView()
    }
    
    func refreshView() {
        let width = 17
        let height = 15
        if imgArr.count == 0 {
            for i in 0..<count{
                let imgView = UIImageView(image: UIImage(named: "red_star"))
              imgView.frame = CGRectMake(CGFloat(i*width), 0, CGFloat(width), CGFloat(height))
                self.imgArr.append(imgView)
                self.addSubview(imgView)
            }
            for i in count..<5 {
                let imgView = UIImageView(image: UIImage(named: "grey_star"))
                imgView.frame = CGRectMake(CGFloat(i*width), 0, CGFloat(width), CGFloat(height))
                self.imgArr.append(imgView)
                self.addSubview(imgView)
            }
        }
        else{
            for i in 0..<count{
                imgArr[i].image = UIImage(named: "red_star")
            }
            for i in count..<5 {
                imgArr[i].image = UIImage(named: "grey_star")
            }
        }
        
    }
}
