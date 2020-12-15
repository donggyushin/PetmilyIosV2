//
//  PuppyViewController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

class PuppyViewController: UIViewController {

    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "분양"
        return label
    }()
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        clearNavigationBar()
        
        view.backgroundColor = .systemBackground
    }

}
