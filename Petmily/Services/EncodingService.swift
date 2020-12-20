//
//  EncodingService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import Foundation

class EncodingService {
    static let shared = EncodingService()
    
    func encodeString(urlString:String) -> String {
        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
