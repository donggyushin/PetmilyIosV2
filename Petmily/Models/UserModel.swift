//
//  UserModel.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/26.
//

import Foundation


struct UserModel:Codable {
    var roles:[String]
    var userFirebaseToken:String?
    var userImageUrl:String?
    var userNickName:String
    var userPhoneNumber:String 
}
