//
//  LocalDataService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import Foundation


class LocalDataService {
    static let shared = LocalDataService()
    
    let defaults = UserDefaults.standard
    
    func setData(value:String, key:String) {
        defaults.set(value, forKey: key)
    }
    
    func removeData(key:String) {
        defaults.removeObject(forKey: key)
    }
    
    func getData(key:String) -> String? {
        if let value = defaults.string(forKey: key) {
            return value
        }else {
            return nil
        }
    }
}
