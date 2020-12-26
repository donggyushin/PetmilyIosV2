//
//  PetKindSelectView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit

protocol PetKindSelectViewProtocol:class {
    func petKindSelectViewTapped(type:String)
}

class PetKindSelectView: UIView {

    // MARK: Properties
    weak var delegate:PetKindSelectViewProtocol?
    
    var type:String?
    
    lazy var petKindLabel:UILabel = {
        let label = UILabel()
        label.text = "품종: "
        return label
    }()
    
    private lazy var forwardImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "icons8-forward-50 1")
        return iv
    }()
    
    private lazy var grayLine:UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
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
        
        addSubview(petKindLabel)
        petKindLabel.translatesAutoresizingMaskIntoConstraints = false
        petKindLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        petKindLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(forwardImageView)
        forwardImageView.translatesAutoresizingMaskIntoConstraints = false
        forwardImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        forwardImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true 
        
        
        addSubview(grayLine)
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        grayLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        grayLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        grayLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
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
    
    // MARK: Selectors
    
    @objc func tapped() {
        guard let type = type else { return }
        self.delegate?.petKindSelectViewTapped(type:type)
    }

}
