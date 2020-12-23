//
//  AuthService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import Foundation
import Alamofire

class AuthService {
    static let shared = AuthService()
    
    func renewalToken(jwt:String, completion:@escaping(Error?, String?, Bool, String?) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/renewalToken?token=\(jwt)")
        guard let url = URL(string: urlString) else { return completion(nil, "URL 객체 생성 실패", false, nil)}
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false, nil)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false, nil) }
                guard let statusCode = response.response?.statusCode else { return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false, nil)}
                switch statusCode {
                case 200:
                    guard let jwt = value["jwt"] as? String else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false, nil) }
                    return completion(nil, nil, true, jwt)
                case 401:
                    guard let message = value["message"] as? String else { return completion(nil, "서버로부터 제대로 된 에러메시지를 받아오고 있지 못하고 있습니다.", false, nil)}
                    return completion(nil, message, false, nil)
                case 409:
                    guard let message = value["message"] as? String else { return completion(nil, "서버로부터 제대로 된 에러메시지를 받아오고 있지 못하고 있습니다.", false, nil)}
                    return completion(nil, message, false, nil)
                default:
                    return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false, nil)
                }
            }
        }
    }
    
    func signIn(id:String, userPassword:String, completion:@escaping(Error?, String?, Bool, String?) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/login")
        guard let url = URL(string: urlString) else { return completion(nil, "URL 객체 생성 실패", false, nil)}
        let parameters:[String:Any] = [
            "id": id,
            "userPassword": userPassword
        ]
        
        AF.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false, nil)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false, nil) }
                guard let statusCode = response.response?.statusCode else { return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false, nil)}
                switch statusCode {
                case 200:
                    guard let jwt = value["jwt"] as? String else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false, nil) }
                    return completion(nil, nil, true, jwt)
                case 404:
                    guard let message = value["message"] as? String else { return completion(nil, "서버로부터 제대로 된 에러메시지를 받아오고 있지 못하고 있습니다.", false, nil)}
                    return completion(nil, message, false, nil)
                default:
                    return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false, nil)
                }
            }
        }
    }
    
    func signUp(smsAuthNumber:Int, userLoginPassword:String, userNickName:String, userPhoneNumber:String, completion:@escaping(Error?, String?, Bool, String?) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/signUp")
        guard let url = URL(string: urlString) else { return completion(nil, "URL 객체 생성 실패", false, nil)}
        let parameters:[String:Any] = [
            "smsAuthNumber": smsAuthNumber,
            "userLoginPassword": userLoginPassword,
            "userNickName": userNickName,
            "userPhoneNumber": userPhoneNumber
        ]
        AF.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false, nil)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false, nil) }
                guard let statusCode = response.response?.statusCode else { return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false, nil)}
                switch statusCode {
                case 200:
                    guard let jwt = value["jwt"] as? String else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false, nil) }
                    return completion(nil, nil, true, jwt)
                case 409:
                    guard let message = value["message"] as? String else { return completion(nil, "서버로부터 제대로 된 에러메시지를 받아오고 있지 못하고 있습니다.", false, nil)}
                    return completion(nil, message, false, nil)
                default:
                    return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false, nil)
                }
            }
        }
    }
    
    
    func validateAuthNumber(authSms:Int, callNumber:String, userName:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/validateAuthNumber")
        guard let url = URL(string: urlString) else { return completion(nil, "URL 객체 생성 실패", false)}
        let parameters:[String : Any] = [
            "authSms":authSms,
            "callNumber": callNumber,
            "userName": userName
        ]
        
        AF.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false)}
                guard let statusCode = response.response?.statusCode else { return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false)}
                switch statusCode {
                case 200:
                    return completion(nil, nil, true)
                case 409:
                    guard let message = value["message"] as? String else { return completion(nil, "서버로부터 제대로 된 에러메시지를 받아오고 있지 못하고 있습니다.", false)}
                    return completion(nil, message, false)
                default:
                    return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false)
                }
            }
        }
    }
    
    func requestAuthNumber(callNumber:String, userName:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/sendAuthNumber")
        guard let url = URL(string: urlString) else { return completion(nil, "url 객체 만들기 실패", false)}
        let parameters = [
            "callNumber":callNumber,
            "userName":userName
        ]
        AF.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false)}
                guard let statusCode = response.response?.statusCode else { return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false)}
                print("value:\(value)")
                switch statusCode {
                case 200:
                    return completion(nil, nil, true)
                case 409:
                    guard let message = value["message"] as? String else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false) }
                    return completion(nil, message, false)
                    
                default:
                    guard let message = value["message"] as? String else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false) }
                    return completion(nil, message, false)
                }
            }
        }
    }
    
    func checkPassword(password:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/checkPassword?password=\(password)")
        guard let url = URL(string: urlString) else { return completion(nil, "url 객체를 생성 할 수 없습니다.", false)}
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false)}
                guard let statusCode = response.response?.statusCode else { return completion(nil, "현재 서버 네트워크의 상태가 불안전합니다. 잠시 후에 다시 시도해주세요 ㅠ_ㅠ", false)}
                print("statusCode:\(statusCode)")
                switch statusCode {
                case 200:
                    return completion(nil, nil, true)
                    
                case 409:
                    guard let message = value["message"] as? String else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false) }
                    return completion(nil, message, false)
                default:
                    return completion(nil, "올바르지 않은 status code", false)
                }
                 
            }
        }
    }
    
    func checkUsernickname(username:String, completion:@escaping(Error?, String?, Bool) -> Void) {
        let urlString = EncodingService.shared.encodeString(urlString: "\(ApiEndpoint.shared.PetMilyBaseUrl)/api/v1/user/checkUserNickName?nickName=\(username)")
        guard let url = URL(string: urlString) else { return completion(nil, "url 객체 만드는데 실패", false)}
        AF.request(url, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                return completion(error, nil, false)
            case .success(let value):
                guard let value = value as? [String:Any] else { return completion(nil, "제대로 된 value를 받아오고 있지 못하고 있습니다.", false)}
                guard let statusCode = response.response?.statusCode else { return completion(nil, "status code를 받아올 수 없습니다.", false)}
                switch statusCode {
                case 200:
                    return completion(nil, nil, true)
                case 409:
                    guard let message = value["message"] as? String else { return completion(nil, "서버로부터 에러 메시지를 받아올 수 없습니다.", false)}
                    return completion(nil, message, false)
                default:
                    return completion(nil, "올바르지 않은 status code", false)
                }
            }
        }
    }
    
    
    func isLoggedIn() -> Bool {
        if let _ = LocalDataService.shared.getData(key: AuthKeys.shared.AUTH) {
            return true
        }else {
            return false
        }
    }
}
