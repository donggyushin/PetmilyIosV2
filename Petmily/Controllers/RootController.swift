//
//  RootController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

class RootController: UITabBarController, UITabBarControllerDelegate {

    // MARK: Properties
    var user:UserModel? {
        didSet {
            guard let user = user else { return }
            let myController = RootControllerService.shared.getMyController()
            myController.user = user
        }
    }
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        
        
        self.delegate = self
        
    }// MARK: Apis
    func fetchUser(token:String) {
        UserService.shared.fetchUser(token: token, completion: { (error, errorMessage, success, refreshToken, user) in
            
            if let refreshToken = refreshToken {
                // TODO: 토큰 재발급
                AuthService.shared.renewalToken(refreshToken: refreshToken) { (success, jwt) in
                    if success {
                        guard let jwt = jwt else { return }
                        self.fetchUser(token: jwt)
                    }
                }
                return
            }
            
            if success {
                guard let user = user else { return }
                self.user = user
            }else {
                
                return self.presentAlertWithOnlyOkayButton(title: nil, message: "현재 네트워크 상태가 불안정합니다. 이용에 불편을 드려 죄송합니다", handler: nil)
            }
        })
    }
    
    // MARK: Configures
    func loginUser(jwt:String,refreshJwt:String) {
        LocalDataService.shared.setData(value: jwt, key: AuthKeys.shared.AUTH)
        LocalDataService.shared.setData(value: refreshJwt, key: AuthKeys.shared.REFRESH_TOKEN)
        configureViewControllers()
        
        
    }
    
    func logoutUser() {
        LocalDataService.shared.removeData(key: AuthKeys.shared.AUTH)
        configureViewControllers()
        selectedIndex = 3
    }
    
    
    func configureViewControllers() {
        view.backgroundColor = .systemBackground
        viewControllers = []
        
        let puppyViewController = UINavigationController(rootViewController: PuppyViewController())
        
        puppyViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-dog-house-100 2")
        puppyViewController.tabBarItem.tag = 0
        
        let petViewController = UINavigationController(rootViewController: PetViewController())
        petViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-pet-commands-summon-100 2")
        petViewController.tabBarItem.tag = 1
        
        let postController = UINavigationController(rootViewController: PostViewController())
        
        postController.tabBarItem.image = #imageLiteral(resourceName: "image 1")
        postController.tabBarItem.tag = 2
        
        let myViewController = UINavigationController(rootViewController: MyViewController())
        myViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-info-50 1")
        myViewController.tabBarItem.tag = 3
        
        viewControllers = [puppyViewController, petViewController,postController, myViewController]
        
        if let token = LocalDataService.shared.getData(key: AuthKeys.shared.AUTH) {
            fetchUser(token: token)
        }
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 2 {
            
            let postController = UINavigationController(rootViewController: PostViewController())
            postController.modalPresentationStyle = .fullScreen
            self.present(postController, animated: true, completion: nil)
            
            return false
        }else {
            return true
        }
    }


}


