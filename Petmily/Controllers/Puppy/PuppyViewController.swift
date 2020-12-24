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
    
    private lazy var plusButton:BlueButton = {
        let plusButton = BlueButton()
        plusButton.delegate = self
        return plusButton
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
        
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        plusButton.layer.cornerRadius = 25
        
        
    }
    
    

}


extension PuppyViewController:BlueButtonProtocol {
    func blueButtonTapped(sender: BlueButton) {
        
        
        let puppyPostController = PuppyPostController()
        
        puppyPostController.modalPresentationStyle = .fullScreen
        
        present(puppyPostController, animated: true, completion: nil)
        
//        navigationController?.pushViewController(puppyPostController, animated: true)
    }
}
