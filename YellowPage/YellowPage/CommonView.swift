//
//  CommonView.swift
//  YellowPage
//
//  Created by Halcao on 2017/2/22.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import UIKit

class CommonView: UIView {

    var collectionView: UICollectionView! = nil
    var models: [ClientItem] = []
    
    let titles = ["1895服务大厅", "图书馆", "维修服务中心", "智能自行车", "学生宿舍管理中心", "校医院"]
    let icons = ["icon-1895", "icon-library", "icon-repair", "icon-bike", "icon-building", "icon-hospital"]

    
    // FIXME: fix init
    convenience init(with models: [ClientItem]) {
        self.init()
        self.models = models
        self.backgroundColor = UIColor.white
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 20, width: 0, height: 0))
        headerLabel.text = "常用部门"
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        headerLabel.sizeToFit()
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: headerLabel.frame.size.height+30, width: width, height: 150), collectionViewLayout: layout)
        
        // initial fix
        //collectionView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        //collectionView.contentSize = CGSize(width: width, height: 150)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CommonClientCell.self, forCellWithReuseIdentifier: "CommonClientCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        layout.itemSize = CGSize(width: (width-50)/2, height: 40)
        self.addSubview(headerLabel)
        self.addSubview(collectionView)
    }
        /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


// delegate and dataSource
extension CommonView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return models.count
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonClientCell", for: indexPath) as! CommonClientCell
        
        // load data
        cell.load(with: titles[indexPath.row], and: icons[indexPath.row])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 15, 5, 15)
    }
    
}
