//
//  SignUpStepOneController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import UIKit

class SignUpAuthNumberController: UIViewController {
    
    // MARK: Properties
    let username:String
    let password:String
    var phoneNumber:String?
    
    
    private lazy var phoneVerificationTextFieldView:TextFieldViewTypeOne = {
        let view = TextFieldViewTypeOne()
        view.textField.placeholder = "010 - 1234 - 1234"
        view.textField.textAlignment = .center
        view.textField.font = UIFont.systemFont(ofSize: 20)
        view.textField.keyboardType = .numberPad
        view.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view.textField.delegate = self
        return view
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
    
    init(username:String, password:String) {
        self.username = username
        self.password = password
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        view.addSubview(phoneVerificationTextFieldView)
        phoneVerificationTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        phoneVerificationTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        phoneVerificationTextFieldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        phoneVerificationTextFieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        phoneVerificationTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        requestButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        requestButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        requestButton.topAnchor.constraint(equalTo: phoneVerificationTextFieldView.bottomAnchor, constant: 20).isActive = true
        
        
        view.addSubview(codeTextView)
        codeTextView.translatesAutoresizingMaskIntoConstraints = false
        codeTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        codeTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        codeTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        codeTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        codeTextView.isHidden = true
        
        view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        checkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        checkButton.topAnchor.constraint(equalTo: phoneVerificationTextFieldView.bottomAnchor, constant: 20).isActive = true
        checkButton.isHidden = true
        
        view.addSubview(resendButton)
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        resendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        resendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        resendButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20).isActive = true
        resendButton.isHidden = true
        
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
    }
    
    // MARK: Helpers
    func makeNewAccount(smsAuthNumber:Int, userLoginPassword:String, userNickName:String, userPhoneNumber:String) {
        loadingView.isHidden = false
        AuthService.shared.signUp(smsAuthNumber: smsAuthNumber, userLoginPassword: userLoginPassword, userNickName: userNickName, userPhoneNumber: userPhoneNumber) { (error, errorString, success, jwt) in
            self.loadingView.isHidden = true
            self.handleError(error: error, errorMessage: errorString, success: success)
            guard let jwt = jwt else { return self.presentAlertWithOnlyOkayButton(title: nil, message: "현재 네트워크 상태가 좋지 않습니다. 나중에 다시 시도해주세요 ㅠ_ㅠ", handler: nil)}
            // 이제 이 jwt 가지고 로그인시켜주고 쌩쑈를 하면 된당
            let rootController = RootControllerService.shared.getRootController()
            rootController.loginUser(jwt: jwt)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Selectors
    @objc func resendButtonTapped() {
        self.phoneVerificationTextFieldView.isHidden = false
        self.requestButton.isHidden = false
        self.codeTextView.isHidden = true
        self.checkButton.isHidden = true
        self.resendButton.isHidden = true
        
        self.phoneVerificationTextFieldView.textField.text = ""
        dismissKeyboard()
    }
    
    @objc func checkButtonTapped() {
        guard let authSmsCodeString = codeTextView.textField.text else { return }
        guard let phoneNumber = self.phoneNumber else { return }
        guard let authSms = Int(authSmsCodeString) else { return }
        loadingView.isHidden = false
        dismissKeyboard()
        AuthService.shared.validateAuthNumber(authSms: authSms, callNumber: phoneNumber, userName: self.username) { (error, errorMessage, success) in
            self.loadingView.isHidden = true
            self.handleError(error: error, errorMessage: errorMessage, success: success)
            
            self.loadingView.isHidden = false
            self.makeNewAccount(smsAuthNumber: authSms, userLoginPassword: self.password, userNickName: self.username, userPhoneNumber: phoneNumber)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == phoneVerificationTextFieldView.textField {
            guard let text = textField.text else { return }
            
            if let lastText = text.last {
                if (lastText == " ") {
                    textField.text = String(textField.text!.dropLast(3))
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
    
    @objc func requestButtonTapped(sender:UIButton) {
        
        
        guard let phoneString = self.phoneVerificationTextFieldView.textField.text else { return }
        let formattedPhoneString = phoneString.replacingOccurrences(of: " - ", with: "")
        if formattedPhoneString.count < 11 { return }
        
        self.phoneNumber = formattedPhoneString
        
        dismissKeyboard()
        loadingView.isHidden = false
        
        AuthService.shared.requestAuthNumber(callNumber: formattedPhoneString, userName: self.username) { (error, errorMessage, success) in
            self.loadingView.isHidden = true
            self.handleError(error: error, errorMessage: errorMessage, success: success)
            
            print("핸드폰 인증 요청!!")
            self.phoneVerificationTextFieldView.isHidden = true
            self.requestButton.isHidden = true
            self.codeTextView.isHidden = false
            self.checkButton.isHidden = false 
            self.resendButton.isHidden = false
        }

    }
}



extension SignUpAuthNumberController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneVerificationTextFieldView.textField {
            let maxLength = 17
            guard let currentString = textField.text as NSString? else { return true}
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
        return true
    }
}
