//
//  ForgotPasswordController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/21.
//

import UIKit

class ForgotPasswordController: UIViewController {

    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "비밀번호 찾기"
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
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

}
