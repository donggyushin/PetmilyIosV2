//
//  LoadingView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import UIKit

class LoadingView: UIView {

    // MARK: Properties
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
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
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

}
