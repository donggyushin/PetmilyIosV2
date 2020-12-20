//
//  TextFieldViewTypeOne.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/16.
//

import UIKit

class TextFieldViewTypeOne: UIView {

    // MARK: Properties
    lazy var textField:UITextField = {
        let tf = UITextField()
        return tf
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
        textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true 
    }

}
