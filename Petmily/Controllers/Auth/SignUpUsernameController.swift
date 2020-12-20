//
//  SignUpUserNameController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/20.
//

import UIKit

class SignUpUsernameController: UIViewController {
    
    // MARK: Properties
    private lazy var usernameTextFieldView:TextFieldViewTypeOne = {
        let view = TextFieldViewTypeOne()
        view.textField.placeholder = "사용할 닉네임을 입력해주세요"
        view.textField.textAlignment = .center
        return view
    }()
    
    private lazy var checkUsernameButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("조회하기", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(checkButtonTapped), for: UIControl.Event.touchUpInside)
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
    func configureKeyboard(){
        dismissKeyboardOutside()
        moveViewHalfWhenKeyboardAppeared()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.backButtonTitle = "닉네임 설정"
        
        view.addSubview(usernameTextFieldView)
        usernameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextFieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        usernameTextFieldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        usernameTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(checkUsernameButton)
        checkUsernameButton.translatesAutoresizingMaskIntoConstraints = false
        checkUsernameButton.topAnchor.constraint(equalTo: usernameTextFieldView.bottomAnchor, constant: 20).isActive = true
        checkUsernameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        checkUsernameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        checkUsernameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
        guard let text = self.usernameTextFieldView.textField.text else { return }
        dismissKeyboard()
        
        if RegularExpressionService.shared.checkString(testString: text, pattern: RegularExpressionService.shared.usernameReg) == false {
            return self.presentAlertWithOnlyOkayButton(title: nil, message: "사용할 수 없는 닉네임입니다.", handler: nil)
        }
        
        loadingView.isHidden = false
        AuthService.shared.checkUsernickname(username: text) { (error, errorMessage, success) in
            self.loadingView.isHidden = true
            self.handleError(error: error, errorMessage: errorMessage, success: success)
            
            let signUpPasswordController = SignUpPasswordController(userName: text)
            self.navigationController?.pushViewController(signUpPasswordController, animated: true)
            
            
        }
    }

}
