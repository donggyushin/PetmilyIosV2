//
//  SelectImageView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/26.
//

import UIKit
import YPImagePicker

private let addButtonCellIdentifier = "addButtonCellIdentifier"
private let petphotoCellIdentifier = "petphotoCellIdentifier"


protocol SelectImageViewProtocol:class {
    func selectImageViewPresentPicker(picker:YPImagePicker)
}

class SelectImageView: UIView {

    // MARK: Properties
    weak var delegate:SelectImageViewProtocol?
    
    var petPhotoImages:[PostPhotoModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var picker:YPImagePicker?
    
    
    
    private lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .secondarySystemBackground
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureCollectionView()
        configureYPImagePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configureCollectionView() {
        collectionView.register(AddButtonCell.self, forCellWithReuseIdentifier: addButtonCellIdentifier)
        collectionView.register(PetPhotoCell.self, forCellWithReuseIdentifier: petphotoCellIdentifier)
    }
    
    func configureYPImagePicker() {
        var config = YPImagePickerConfiguration()
        
        config.screens = [.library]
        config.library.maxNumberOfItems = 9
        config.showsPhotoFilters = false
        
        config.wordings.albumsTitle = "앨범"
        config.wordings.cancel = "취소"
        config.wordings.next = "다음"
        config.wordings.libraryTitle = "갤러리"
        config.wordings.warningMaxItemsLimit = "총 9장의 사진까지 선택하실 수 있습니다."
        
        self.picker = YPImagePicker(configuration: config)
    }
    
    func configureUI() {
        backgroundColor = .secondarySystemBackground
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}



extension SelectImageView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.petPhotoImages.count < 9 {
            return self.petPhotoImages.count + 1
        }else {
            return 9
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if self.petPhotoImages.count < 9 {
            if indexPath.row > self.petPhotoImages.count - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addButtonCellIdentifier, for: indexPath) as! AddButtonCell
                cell.delegate = self
                return cell
            }else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: petphotoCellIdentifier, for: indexPath) as! PetPhotoCell
                let petPhoto = self.petPhotoImages[indexPath.row]
                cell.image = petPhoto
                return cell
            }
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: petphotoCellIdentifier, for: indexPath) as! PetPhotoCell
            let petPhoto = self.petPhotoImages[indexPath.row]
            cell.image = petPhoto
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ScreenSize.shared.width / 3 - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    
}


extension SelectImageView:AddButtonCellProtocol {
    func addButtonCellTapped(sender: AddButtonCell) {
        
        guard let picker = self.picker else { return }
        
        picker.didFinishPicking(completion: { (items, cancelled) in
            var index = 0
            self.petPhotoImages = []
            for item in items {
                switch item {
                case .photo(let photo):
                    let image = photo.image
                    let postPetPhoto = PostPhotoModel(index: index, image: image)
                    self.petPhotoImages.append(postPetPhoto)
                    index += 1
                    break
                default:
                    break
                }
            }
            picker.dismiss(animated: true, completion: nil)
        })
        
        
        delegate?.selectImageViewPresentPicker(picker: picker)
        
        
    }
}
