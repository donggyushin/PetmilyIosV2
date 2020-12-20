//
//  AuthController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/16.
//

import UIKit

class AuthController: UIViewController {

    // MARK: Properties
    private lazy var titleLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "펫밀리"
        return label
    }()
    
    private lazy var backButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("돌아가기", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(backButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var idTextView:TextFieldViewTypeOne = {
        let tv = TextFieldViewTypeOne()
        tv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tv.textField.placeholder = "아이디를 입력해주세요"
        return tv
    }()
    
    private lazy var passwordTextView:TextFieldViewTypeOne = {
        let tv = TextFieldViewTypeOne()
        tv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tv.textField.placeholder = "비밀번호를 입력해주세요"
        tv.textField.isSecureTextEntry = true
        return tv
    }()
    
    private lazy var textFieldStackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [idTextView, passwordTextView])
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var loginButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("로그인", for: UIControl.State.normal)
        return bt
    }()
    
    private lazy var redirectButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        

        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16)]
        let secondAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]

        let firstString = NSMutableAttributedString(string: "아직 계정이 없으신가요? ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "회원가입", attributes: secondAttributes)

        firstString.append(secondString)
        bt.setAttributedTitle(firstString, for: UIControl.State.normal)
        
        bt.addTarget(self, action: #selector(redirectToSignUpController), for: UIControl.Event.touchUpInside)
        return bt
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
        // TODO: - keyboard 설정 처리
        moveViewHalfWhenKeyboardAppeared()
        dismissKeyboardOutside()
    }
    
    func configureUI() {
        clearNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.backButtonTitle = "이전"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)
        view.backgroundColor = .systemBackground
        
        view.addSubview(textFieldStackView)
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false 
        textFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textFieldStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        textFieldStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(redirectButton)
        redirectButton.translatesAutoresizingMaskIntoConstraints = false
        redirectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redirectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
    }
    
    // MARK: Selectors
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func redirectToSignUpController() {
        let usernameController = SignUpUsernameController()
        navigationController?.pushViewController(usernameController, animated: true)
    }

}
