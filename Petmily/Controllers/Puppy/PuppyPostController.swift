//
//  PuppyPostController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import UIKit

class PuppyPostController: UIViewController {
    
    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "분양하기"
        return label
    }()
    
    private lazy var closeButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("닫기", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(closeButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var topView:UIView = {
        let view = UIView()
        return view
    }()

    // MARK: Lifecycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    
    // MARK: Configures
    func configureUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        let pullDownModalRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pullDownModalHandler))
        
        topView.addGestureRecognizer(pullDownModalRecognizer)
    }
    
    
    // MARK: Selectors
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
