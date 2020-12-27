//
//  SelectDateController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit

protocol SelectDateControllerProtocol:class {
    func selectDateControllerBirthDate(year:String, month:String, day:String)
}

class SelectDateController: UIViewController {
    
    

    // MARK: Properties
    weak var delegate:SelectDateControllerProtocol?
    
    private lazy var datePicker:DatePickerView = {
        let view = DatePickerView()
        view.delegate = self
        return view
    }()
    
    private lazy var okayButton:BlueButton = {
        let bt = BlueButton()
        bt.label.text = "다음"
        bt.delegate = self
        return bt
    }()
    
    var year:String?
    var month:String?
    var day:String?
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
    }
    // MARK: Configures
    func configureUI() {
        dismissKeyboardOutside()
        moveViewHalfWhenKeyboardAppeared()
        
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(okayButton)
        okayButton.translatesAutoresizingMaskIntoConstraints = false
        okayButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        okayButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        okayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        okayButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        okayButton.isHidden = true 
    }

}


extension SelectDateController:DatePickerViewProtocol {
    func dateUpdated(year: String?, month: String?, day: String?) {
        self.year = year
        self.month = month
        self.day = day
        
        if year != nil && month != nil && day != nil {
            self.okayButton.isHidden = false
        }else {
            self.okayButton.isHidden = true
        }
    }
}


extension SelectDateController:BlueButtonProtocol {
    func blueButtonTapped(sender: BlueButton) {
        guard let year = self.year else { return }
        guard let month = self.month else { return }
        guard let day = self.day else { return }
        
        self.delegate?.selectDateControllerBirthDate(year: year, month: month, day: day)
        navigationController?.popViewController(animated: true)
    }
}
