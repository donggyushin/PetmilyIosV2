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
    
    func getMyController() -> MyViewController {
        let rootController = getRootController()
        let navigationMyController = rootController.viewControllers?[3] as! UINavigationController
        let myController = navigationMyController.viewControllers[0] as! MyViewController
        return myController
    }
}
