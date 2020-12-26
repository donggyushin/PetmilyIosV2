//
//  AddButtonCell.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/26.
//

import UIKit

protocol AddButtonCellProtocol:class {
    func addButtonCellTapped(sender:AddButtonCell)
}

class AddButtonCell: UICollectionViewCell {
    
    // MARK: Properties
    weak var delegate:AddButtonCellProtocol?
    
    private lazy var plusLabel:UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = UIFont.systemFont(ofSize: 40)
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
    // MARK: Configures
    func configureUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        
        addSubview(plusLabel)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plusLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        
    }
    
    // MARK: Selectors
    
    @objc func tapped() {
        self.delegate?.addButtonCellTapped(sender: self)
    }
}
