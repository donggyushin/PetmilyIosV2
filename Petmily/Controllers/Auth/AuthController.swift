//
//  AuthController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/16.
//

import UIKit

class AuthController: UIViewController {

    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "펫밀리"
        return label
    }()
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        clearNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        view.backgroundColor = .systemBackground
    }

}
