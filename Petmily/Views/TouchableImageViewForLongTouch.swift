//
//  TouchableImageViewForLongTouch.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/21.
//

import UIKit

protocol TouchableImageViewForLongTouchDelegate:class {
    func touchesBegan(sender:TouchableImageViewForLongTouch)
    func touchesEnd(sender:TouchableImageViewForLongTouch)
}

class TouchableImageViewForLongTouch: UIView {

    // MARK: Properties
    weak var delegate:TouchableImageViewForLongTouchDelegate?
    
    lazy var imageView:UIImageView = {
        let iv = UIImageView()
        return iv
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
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
        print("touchesBegan")
        self.delegate?.touchesBegan(sender: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        print("touchesCancelled")
        self.delegate?.touchesEnd(sender: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        print("touchesEnded")
        self.delegate?.touchesEnd(sender: self)
    }

}
