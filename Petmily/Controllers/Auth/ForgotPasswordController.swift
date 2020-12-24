//
//  ForgotPasswordController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/21.
//

import UIKit

class ForgotPasswordController: UIViewController {

    // MARK: Properties
    var phoneNumber:String?
    
    
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "비밀번호 찾기"
        return label
    }()
    
    private lazy var phoneTextField:TextFieldViewTypeOne = {
        let tv = TextFieldViewTypeOne()
        tv.textField.placeholder = "010 - 1234 - 1234"
        tv.textField.textAlignment = .center
        tv.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tv.textField.delegate = self
        tv.textField.font = UIFont.systemFont(ofSize: 20)
        tv.textField.keyboardType = .numberPad
        return tv
    }()
    
    private lazy var requestButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("인증번호 요청", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(requestButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    private lazy var codeTextView:TextFieldViewTypeOne = {
        let view = TextFieldViewTypeOne()
        view.textField.placeholder = "123456"
        view.textField.textAlignment = .center
        view.textField.font = UIFont.systemFont(ofSize: 20)
        view.textField.textContentType = .oneTimeCode
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    
    private lazy var checkButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("확인", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(checkButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var resendButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("재전송", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(resendButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        configureKeyboard()
    }
    
    // MARK: Configures
    func configureKeyboard() {
        moveViewHalfWhenKeyboardAppeared()
        dismissKeyboardOutside()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.backButtonTitle = "인증"
        
        view.addSubview(phoneTextField)
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20).isActive = true
        requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        requestButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        requestButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        requestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        view.addSubview(codeTextView)
        codeTextView.translatesAutoresizingMaskIntoConstraints = false
        codeTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        codeTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        codeTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        codeTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        codeTextView.isHidden = true
        
        
        view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.topAnchor.constraint(equalTo: codeTextView.bottomAnchor, constant: 20).isActive = true
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        checkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkButton.isHidden = true
        
        view.addSubview(resendButton)
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        resendButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20).isActive = true
        resendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        resendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        resendButton.isHidden = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
        
    }
    
    
    
    
    // MARK: Selectors
    @objc func checkButtonTapped() {
        guard let smsAuthCode = self.codeTextView.textField.text else { return }
        guard let phoneNumber = self.phoneNumber else { return }
        let forgotPasswordSecondController = ForgotPasswordSecondController(smsAuthCode: smsAuthCode, phoneNumber: phoneNumber)
        navigationController?.pushViewController(forgotPasswordSecondController, animated: true)
    }
    
    @objc func resendButtonTapped() {
        self.phoneTextField.isHidden = false
        self.requestButton.isHidden = false
        
        self.codeTextView.isHidden = true
        self.checkButton.isHidden = true
        self.resendButton.isHidden = true
    }
    
    @objc func requestButtonTapped() {
        
        guard let phoneString = self.phoneTextField.textField.text else { return }
        let formattedPhoneString = phoneString.replacingOccurrences(of: " - ", with: "")
        if formattedPhoneString.count < 11 { return }
        self.phoneNumber = formattedPhoneString
        
        self.loadingView.isHidden = false
        AuthService.shared.requestAuthNumberWhenForgotPassword(callNumber: formattedPhoneString) { (error, errorMessage, success) in
            self.loadingView.isHidden = true
            let result = self.handleError(error: error, errorMessage: errorMessage, success: success)
            if result == false { return }
            
            self.phoneTextField.isHidden = true
            self.requestButton.isHidden = true
            
            self.codeTextView.isHidden = false
            self.checkButton.isHidden = false
            self.resendButton.isHidden = false
            
            
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == phoneTextField.textField {
            guard let text = textField.text else { return }
            
            if let lastText = text.last {
                if (lastText == " ") {
                    textField.text = ""
                    return
                }
            }
            
            // 만약에 새로 들어온 텍스트가 공백이고
            if text.count == 3 {
                textField.text = text + " - "
                
                return
            }
            
            if text.count == 10 {
                textField.text = text + " - "
                return
            }
            
            if text.count >= 17 {
                self.dismissKeyboard()
            }
        }
    }

}



extension ForgotPasswordController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField.textField {
            let maxLength = 17
            guard let currentString = textField.text as NSString? else { return true}
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
        return true
    }
}
