//
//  RootController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

class RootController: UITabBarController, UITabBarControllerDelegate {

    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        self.delegate = self
        
    }
    
    // MARK: Configures
    func loginUser(jwt:String) {
        LocalDataService.shared.setData(value: jwt, key: AuthKeys.shared.AUTH)
        configureViewControllers()
    }
    
    func logoutUser() {
        LocalDataService.shared.removeData(key: AuthKeys.shared.AUTH)
        configureViewControllers()
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


