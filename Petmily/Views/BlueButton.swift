//
//  PlusButton.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import UIKit

protocol BlueButtonProtocol:class {
    func blueButtonTapped(sender:BlueButton)
}

class BlueButton: UIView {

    // MARK: Properties
    weak var delegate: BlueButtonProtocol?
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.text = "+"
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
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
    // MARK: Configures
    func configureUI() {
        backgroundColor = .systemBlue
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
    }
    
    // MARK: Selectors
    @objc func tapped() {
        self.delegate?.blueButtonTapped(sender: self)
    }

}
