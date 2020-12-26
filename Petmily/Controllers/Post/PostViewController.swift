//
//  PostDummyViewController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import UIKit
import YPImagePicker

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
    
    private lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var selectImageView:SelectImageView = {
        let view = SelectImageView()
        view.delegate = self
        return view
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
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(selectImageView)
        selectImageView.translatesAutoresizingMaskIntoConstraints = false
        selectImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        selectImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selectImageView.heightAnchor.constraint(equalToConstant: ScreenSize.shared.width).isActive = true
        
    }
    
    // MARK: Selectors
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension PostViewController:SelectImageViewProtocol {
    
    
    func selectImageViewPresentPicker(picker: YPImagePicker) {
        
        self.present(picker, animated: true, completion: nil)
    }
}
