//
//  PetPhotoCell.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/26.
//

import UIKit

class PetPhotoCell: UICollectionViewCell {
    // MARK: Properties
    var image:PostPhotoModel? {
        didSet {
            guard let image = self.image else { return }
            let uiImage = image.image
            self.imageView.image = uiImage
        }
    }
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
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
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
