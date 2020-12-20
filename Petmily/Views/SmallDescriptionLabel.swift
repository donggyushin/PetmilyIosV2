//
//  SmallDescriptionLabel.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import UIKit

class SmallDescriptionLabel: UILabel {

    // MARK: Properties
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configure(){
        font = UIFont.systemFont(ofSize: 12)
    }
}
