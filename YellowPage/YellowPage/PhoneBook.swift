//
//  PhoneBook.swift
//  YellowPage
//
//  Created by Halcao on 2017/2/22.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import UIKit

class PhoneBook: NSObject {
    static let shared = PhoneBook()
    private override init() {}
    
    func getPhoneNumber(with string: String) -> String? {
        
        return ""
    }
    
    func getMembers(with string: String) -> [String] {
        if string == "校级部门" {
            return ["计算机学院团委办公室", "信息学院团委办公室", "软件学院团委办公室"]
        }
        return []
    }
    
    func getSections() -> [String] {
        return ["校级部门", "院级部门", "其他部门"]
    }
    
    func getFavorite() -> [String] {
        return ["计算机学院团委办公室", "信息学院团委办公室", "软件学院团委办公室"]
    }
}
