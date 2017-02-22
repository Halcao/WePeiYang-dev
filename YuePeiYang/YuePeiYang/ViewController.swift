//
//  ViewController.swift
//  YuePeiYang
//
//  Created by Halcao on 2016/10/22.
//  Copyright © 2016年 Halcao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SearchDelegate {

    var search: Search!
    override func viewDidLoad() {
        super.viewDidLoad()
        let infoVC = InfoViewController(style: .Grouped)
        infoVC.view.frame = self.view.frame;
        self.addChildViewController(infoVC)
        self.view.addSubview(infoVC.view)
        self.title = "我的"
        let searchItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(pushSearchController))
        self.navigationItem.rightBarButtonItem  = searchItem
    }

    func pushSearchController() {
        search = Search(frame: self.view.bounds)
        search.delegate = self
        if let window = UIApplication.sharedApplication().keyWindow {
            window.addSubview(self.search)
            self.search.animate()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func hideSearchView(status : Bool){
        if status == true {
            self.search.removeFromSuperview()
        }
    }
    
}

