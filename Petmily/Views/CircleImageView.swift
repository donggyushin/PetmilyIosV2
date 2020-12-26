//
//  CircleImageView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/26.
//

import UIKit

class CircleImageView: UIImageView {
    

    // MARK: Lifecycles
    
    init() {
        super.init(frame: CGRect.zero)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configureUI() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        backgroundColor = .secondarySystemFill
    }
    

}
