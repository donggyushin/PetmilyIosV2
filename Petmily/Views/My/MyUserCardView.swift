//
//  MyUserCardView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/26.
//

import UIKit
import SDWebImage


class MyUserCardView: UIView {
    
    // MARK: Properties
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            if let userProfileImage = user.userImageUrl {
                if let url = URL(string: userProfileImage) {
                    self.userProfileImageView.sd_setImage(with: url, completed: nil)
                }
            }
            self.usernameLabel.text = user.userNickName
            self.phoneNumberLabel.text = user.userPhoneNumber
        }
    }
    
    private lazy var userProfileImageView:CircleImageView = {
        let iv = CircleImageView()
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    private lazy var usernameLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var phoneNumberLabel:SmallDescriptionLabel = {
        let label = SmallDescriptionLabel()
        return label
    }()
    
    private lazy var logoutButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("로그아웃", for: UIControl.State.normal)
        bt.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(logoutButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()

    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    @objc func logoutButtonTapped() {
        let root = RootControllerService.shared.getRootController()
        root.logoutUser()
    }
    
    // MARK: Configures
    func configureUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 7
        
        
        addSubview(userProfileImageView)
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        userProfileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 15).isActive = true
        
        addSubview(phoneNumberLabel)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        phoneNumberLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        
        addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true 
    }

}
