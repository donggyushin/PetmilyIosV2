//
//  UnloggedInView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/16.
//

import UIKit

protocol UnLoggedInViewProtocol:class {
    func redirectToAuthController(sender:UnLoggedInView)
}

class UnLoggedInView: UIView {

    // MARK: Properties
    weak var delegate:UnLoggedInViewProtocol?
    
    private lazy var redirectCardToAuthController:ClickableCardViewTypeOne = {
        let card = ClickableCardViewTypeOne()
        card.label.text = "아직 펫밀리의 회원이 아니신가요?\n펫밀리에 가입하시고 반려동물들에게 더 좋은 세상을 선물해요!"
        card.delegate = self
        card.widthAnchor.constraint(equalToConstant: ScreenSize.shared.width * 0.9).isActive = true
        card.heightAnchor.constraint(equalToConstant: 500).isActive = true
        return card
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
        addSubview(redirectCardToAuthController)
        redirectCardToAuthController.translatesAutoresizingMaskIntoConstraints = false
        redirectCardToAuthController.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        redirectCardToAuthController.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}


extension UnLoggedInView:ClickableCardViewTypeOneProtocol {
    func clickableCardViewTypeOneTapped(sender: ClickableCardViewTypeOne) {
        self.delegate?.redirectToAuthController(sender: self)
    }
}
