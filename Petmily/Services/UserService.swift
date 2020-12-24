//
//  UserService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import Foundation
import Alamofire

class UserService {
    static let shared = UserService()
    
    func resetPassword(authSms:String, callNumber:String, newPassword:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/auth/resetPassword")
        guard let url = URL(string: urlString) else { return completion(nil, "URL 객체를 생성하지 못하였습니다.", false)}
        let parameters = [
            "authSms":authSms,
            "callNumber":callNumber,
            "newPassword":newPassword
        ]
        AF.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false)
            case .success(let value):
                guard let value = value as? [String:Any] else { return }
                guard let statusCode = response.response?.statusCode else { return }
                
                switch statusCode {
                case 200:
                    return completion(nil, nil, true)
                default:
                    let message = value["message"] as? String ?? "알수없는 에러 발생"
                    return completion(nil, message, false)
                }
            }
        }
    }
}