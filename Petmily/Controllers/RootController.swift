//
//  RootController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

class RootController: UITabBarController {

    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
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
        
        let petViewController = UINavigationController(rootViewController: PetViewController())
        petViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-pet-commands-summon-100 2")
        
        let myViewController = UINavigationController(rootViewController: MyViewController())
        myViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-info-50 1")
        
        viewControllers = [puppyViewController, petViewController, myViewController]
    }
    

}
