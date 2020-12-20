//
//  RegularExpressionService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import Foundation

class RegularExpressionService {
    static let shared = RegularExpressionService()
    
    let usernameReg = "^.*(?=^.{2,20}$)[가-힣0-9a-zA-Z].*"
    let passwordReg = "^.*(?=^.{8,32}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[.,/\\!@#$%^*+=-]).*$"
    
    func checkString(testString:String, pattern:String) -> Bool {
        let range = NSRange(location: 0, length: testString.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: testString, options: [], range: range) != nil
    }
}
