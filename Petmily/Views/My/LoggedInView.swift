//
//  LoggedInView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/16.
//

import UIKit

class LoggedInView: UIView {

    // MARK: Properties
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            self.myCardView.user = user
        }
    }
    
    private lazy var myCardView:MyUserCardView = {
        let view = MyUserCardView()
        return view
    }()
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configureUI() {
        backgroundColor = .systemBackground
        
        addSubview(myCardView)
        myCardView.translatesAutoresizingMaskIntoConstraints = false
        myCardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        myCardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        myCardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        myCardView.heightAnchor.constraint(equalToConstant: 70).isActive = true 
    }
}
