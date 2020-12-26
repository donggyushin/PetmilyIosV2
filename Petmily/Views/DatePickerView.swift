//
//  DatePickerView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit

protocol DatePickerViewProtocol:class {
    func dateUpdated(year:String?, month:String?, day:String?)
}

class DatePickerView: UIView {

    // MARK: Properties
    weak var delegate:DatePickerViewProtocol?
    
    lazy var pickerView:UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var textField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "생년월일을 입력해주세요"
        tf.textAlignment = .center
        tf.inputView = pickerView
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        return tf
    }()
    
    
    
    let yearList = BirthdayService.shared.getYearList()
    let monthList = BirthdayService.shared.getMonthList()
    let dayList = BirthdayService.shared.getDayList()
    
    var selectedYear:String? {
        didSet {
            setTextFieldText()
        }
    }
    var selectedMonth:String? {
        didSet {
            setTextFieldText()
        }
    }
    var selectedDay:String? {
        didSet {
            setTextFieldText()
        }
    }
    
    let numberOfComponents = 3
    
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
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    // MARK: Helpers
    func setTextFieldText() {
        
        self.delegate?.dateUpdated(year: selectedYear, month: selectedMonth, day: selectedDay)
        
        self.textField.text = ""
        
        if let year = self.selectedYear {
            self.textField.text = "\(year)년"
        }
        
        if let month = self.selectedMonth {
            self.textField.text? += " \(month)월"
        }
        
        if let day = self.selectedDay {
            self.textField.text? += " \(day)일"
        }
    }

}


extension DatePickerView:UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.yearList.count
        case 1:
            return self.monthList.count
        case 2:
            return self.dayList.count
        default:
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return self.yearList[row]
        case 1:
            return self.monthList[row]
        case 2:
            return self.dayList[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            return self.selectedYear = self.yearList[row]
        case 1:
            return self.selectedMonth = self.monthList[row]
        case 2:
            return self.selectedDay = self.dayList[row]
        default:
            return
        }
    }
    
    
}
