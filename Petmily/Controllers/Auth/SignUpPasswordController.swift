//
//  SignUpPasswordController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import UIKit

class SignUpPasswordController: UIViewController {
    
    // MARK: Properties
    let userName:String
    
    private lazy var passwordTextFieldView:TextFieldViewForPassword = {
        let view = TextFieldViewForPassword()
        view.textField.placeholder = "사용할 비밀번호를 입력해주세요."
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    private lazy var nextButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("다음", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(nextButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()

    // MARK: Lifecycles
    init(userName:String) {
        self.userName = userName
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
    func configureUI() {
        title = self.userName
        view.backgroundColor = .systemBackground
        
        navigationItem.backButtonTitle = "비밀번호 설정"
        
        view.addSubview(passwordTextFieldView)
        passwordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextFieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordTextFieldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 20).isActive = true
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
    }
    
    func configureKeyboard() {
        dismissKeyboardOutside()
        moveViewHalfWhenKeyboardAppeared()
    }
    
    // MARK: Selectors
    @objc func nextButtonTapped() {
        guard let password = self.passwordTextFieldView.textField.text else { return }
        self.loadingView.isHidden = false
        AuthService.shared.checkPassword(password: password) { (error, errorMessage, success) in
            self.loadingView.isHidden = true 
            self.handleError(error: error, errorMessage: errorMessage, success: success)
            
            let authNumberController = SignUpAuthNumberController(username: self.userName, password: password)
            self.navigationController?.pushViewController(authNumberController, animated: true)
        }
    }

}
