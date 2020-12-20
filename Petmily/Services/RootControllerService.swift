//
//  RootControllerService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/21.
//

import UIKit

class RootControllerService {
    static let shared = RootControllerService()
    
    func getRootController() -> RootController {
        return UIApplication.shared.windows.first!.rootViewController as! RootController
    }
}
