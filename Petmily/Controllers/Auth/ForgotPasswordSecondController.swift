//
//  ForgotPasswordSecondController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/25.
//

import UIKit

class ForgotPasswordSecondController: UIViewController {
    
    // MARK: Properties
    let smsAuthCode:String
    let phoneNumber:String
    
    private lazy var passwordTextView:TextFieldViewForPassword = {
        let view = TextFieldViewForPassword()
        view.textField.placeholder = "새로운 비밀번호를 입력해주세요"
        return view
    }()
    
    private lazy var checkButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("확인", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(checkButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    // MARK: Lifecycle
    
    init(smsAuthCode:String, phoneNumber:String) {
        self.smsAuthCode = smsAuthCode
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Helpers
    func navigateToRootController(_ :UIAlertAction) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Selectors
    @objc func checkButtonTapped() {
        guard let newPassword = passwordTextView.textField.text else { return }
        
        self.loadingView.isHidden = false
        
        UserService.shared.resetPassword(authSms: smsAuthCode, callNumber: phoneNumber, newPassword: newPassword) { (error, errorMessage, success) in
            self.loadingView.isHidden = true
            let result = self.handleError(error: error, errorMessage: errorMessage, success: success)
            if result == false { return }
            self.presentAlertWithOnlyOkayButton(title: nil, message: "성공적으로 비밀번호를 변경하였습니다.", handler: self.navigateToRootController)
        }
    }
    
    @objc func gobackToRootController() {
        self.loadingView.isHidden = false 
    }
    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        moveViewHalfWhenKeyboardAppeared()
        dismissKeyboardOutside()
        
        view.addSubview(passwordTextView)
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkButton.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 20).isActive = true
        checkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        checkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
        
    }

}
