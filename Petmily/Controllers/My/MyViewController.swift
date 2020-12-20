//
//  MyViewController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

class MyViewController: UIViewController {
    
    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "My"
        return label
    }()
    
    private lazy var logoutButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("로그아웃", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(logoutButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var unloggedInView:UnLoggedInView = {
        let view = UnLoggedInView()
        view.delegate = self
        return view
    }()
    
    private lazy var loggedInView:LoggedInView = {
        let view = LoggedInView()
        return view
    }()
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        if AuthService.shared.isLoggedIn() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
        }
        
        clearNavigationBar()
        view.backgroundColor = .systemBackground
        
        if AuthService.shared.isLoggedIn() {
            view.addSubview(loggedInView)
            loggedInView.translatesAutoresizingMaskIntoConstraints = false
            loggedInView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            loggedInView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            loggedInView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            loggedInView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }else {
            view.addSubview(unloggedInView)
            unloggedInView.translatesAutoresizingMaskIntoConstraints = false
            unloggedInView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            unloggedInView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            unloggedInView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            unloggedInView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    // MARK: Selectors
    @objc func logoutButtonTapped() {
        let rootController = RootControllerService.shared.getRootController()
        rootController.logoutUser()
    }
    

}


extension MyViewController:UnLoggedInViewProtocol {
    func redirectToAuthController(sender: UnLoggedInView) {
        let authController = UINavigationController(rootViewController: AuthController())
        authController.modalPresentationStyle = .fullScreen
        self.present(authController, animated: true, completion: nil)
    }
}
