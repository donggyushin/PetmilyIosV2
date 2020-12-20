//
//  TextFieldViewForPassword.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/21.
//

import UIKit

class TextFieldViewForPassword: UIView {

    // MARK: Properties
    lazy var textField:UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true 
        return tf
    }()
    
    private lazy var searchIcon:TouchableImageViewForLongTouch = {
        let iv = TouchableImageViewForLongTouch()
        iv.delegate = self
        iv.imageView.image = #imageLiteral(resourceName: "icons8-search-100 3").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
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
    func configureUI(){
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(searchIcon)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        searchIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }

}


extension TextFieldViewForPassword:TouchableImageViewForLongTouchDelegate {
    func touchesBegan(sender: TouchableImageViewForLongTouch) {
        self.textField.isSecureTextEntry = false
    }
    
    func touchesEnd(sender: TouchableImageViewForLongTouch) {
        self.textField.isSecureTextEntry = true
    }
    
    
}
