//
//  AuthService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    func isLoggedIn() -> Bool {
        if let _ = LocalDataService.shared.getData(key: AuthKeys.shared.AUTH) {
            return true
        }else {
            return false
        }
    }
}
