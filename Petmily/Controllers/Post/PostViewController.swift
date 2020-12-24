//
//  PostDummyViewController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "분양하기"
        return label
    }()

    private lazy var closeButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("닫기", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        view.backgroundColor = .systemBackground
        clearNavigationBar()
        
    }
    
    // MARK: Selectors
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
