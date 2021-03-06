//
//  MyViewController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

class MyViewController: UIViewController {
    
    // MARK: Properties
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            self.loggedInView.user = user 
        }
    }
    
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "My"
        return label
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
    
    

}


extension MyViewController:UnLoggedInViewProtocol {
    func redirectToAuthController(sender: UnLoggedInView) {
        RootControllerService.shared.getRootController().presentAuthController()
    }
}
