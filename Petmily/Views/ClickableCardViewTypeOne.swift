//
//  ClickableCardViewTypeOne.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/16.
//

import UIKit

protocol ClickableCardViewTypeOneProtocol:class {
    func clickableCardViewTypeOneTapped(sender:ClickableCardViewTypeOne)
}

class ClickableCardViewTypeOne: UIView {

    // MARK: Properties
    weak var delegate:ClickableCardViewTypeOneProtocol?
    
    lazy var label:SmallDescriptionLabel = {
        let label = SmallDescriptionLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
        layer.cornerRadius = 8
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        
    }
    
    // MARK: Selectors
    @objc func tapped() {
        self.delegate?.clickableCardViewTypeOneTapped(sender: self)
    }

}
