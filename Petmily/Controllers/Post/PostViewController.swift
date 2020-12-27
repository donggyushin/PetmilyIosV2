//
//  PostDummyViewController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import UIKit
import YPImagePicker

class PostViewController: UIViewController {
    
    // MARK: Properties
    var petKind:String?
    var year:String?
    var month:String?
    var day:String?
    
    
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "분양하기"
        return label
    }()

    private lazy var closeButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("닫기", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var selectImageView:SelectImageView = {
        let view = SelectImageView()
        view.delegate = self
        return view
    }()
    
    private lazy var petKindSelectView:PetKindSelectView = {
        let view = PetKindSelectView()
        view.delegate = self
        view.type = "품종"
        view.petKindLabel.text = "품종: "
        return view
    }()
    
    private lazy var locationSelectView:PetKindSelectView = {
        
        let view = PetKindSelectView()
        view.delegate = self
        view.type = "지역"
        view.petKindLabel.text = "지역: "
        return view
    }()
    
    private lazy var datePickerView:PetKindSelectView = {
        let view = PetKindSelectView()
        view.type = "생일"
        view.petKindLabel.text = "생일: "
        view.delegate = self
        return view
    }()
    
    private lazy var selectButtonGroupView:SelectButtonGroupView = {
        let view = SelectButtonGroupView()
        let width = ScreenSize.shared.width / 2 - 20
        view.buttonOne.widthAnchor.constraint(equalToConstant: width).isActive = true
        view.line.widthAnchor.constraint(equalToConstant: width).isActive = true
        view.buttonOne.setTitle("MALE", for: UIControl.State.normal)
        view.buttonTwo.setTitle("FEMALE", for: UIControl.State.normal)
        view.valueOne = "MALE"
        view.valueTwo = "FEMALE"
        view.selectedValue = "MALE"
        return view
    }()
    
    private lazy var nextButton:BlueButton = {
        let bt = BlueButton()
        bt.label.text = "다음"
        return bt
    }()
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        
        navigationItem.backButtonTitle = "분양하기"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        view.backgroundColor = .systemBackground
        clearNavigationBar()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(selectImageView)
        selectImageView.translatesAutoresizingMaskIntoConstraints = false
        selectImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        selectImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selectImageView.heightAnchor.constraint(equalToConstant: ScreenSize.shared.width).isActive = true
        
        scrollView.addSubview(petKindSelectView)
        petKindSelectView.translatesAutoresizingMaskIntoConstraints = false
        petKindSelectView.topAnchor.constraint(equalTo: selectImageView.bottomAnchor).isActive = true
        petKindSelectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        petKindSelectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        petKindSelectView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        scrollView.addSubview(locationSelectView)
        locationSelectView.translatesAutoresizingMaskIntoConstraints = false
        locationSelectView.topAnchor.constraint(equalTo: petKindSelectView.bottomAnchor).isActive = true
        locationSelectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        locationSelectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        locationSelectView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        scrollView.addSubview(datePickerView)
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.topAnchor.constraint(equalTo: locationSelectView.bottomAnchor).isActive = true
        datePickerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        datePickerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        scrollView.addSubview(selectButtonGroupView)
        selectButtonGroupView.translatesAutoresizingMaskIntoConstraints = false
        selectButtonGroupView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor).isActive = true
        selectButtonGroupView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        selectButtonGroupView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        selectButtonGroupView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        selectButtonGroupView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        nextButton.isHidden = true 
    }
    
    // MARK: Selectors
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension PostViewController:SelectImageViewProtocol {
    
    
    func selectImageViewPresentPicker(picker: YPImagePicker) {
        
        self.present(picker, animated: true, completion: nil)
    }
}


extension PostViewController:PetKindSelectViewProtocol {
    func petKindSelectViewTapped(type:String) {
        switch type {
        case "품종":
            let selectPetKindController = SelectPetKindController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(selectPetKindController, animated: true)
            break
        case "생일":
            let selectDateController = SelectDateController()
            selectDateController.delegate = self
            navigationController?.pushViewController(selectDateController, animated: true)
            break
        case "지역":
            let selectLocationController = SelectLocationController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(selectLocationController, animated: true)
            break
        default:
            break
        }
        
    }
}


extension PostViewController:SelectDateControllerProtocol {
    func selectDateControllerBirthDate(year: String, month: String, day: String) {
        self.year = year
        self.month = month
        self.day = day
        
        self.datePickerView.petKindLabel.text = "생일: \(year)년 \(month)월 \(day)일"
    }
}
