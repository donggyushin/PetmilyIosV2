//
//  SelectButtonGroupView.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit

class SelectButtonGroupView: UIView {

    // MARK: Properties
    var valueOne:String?
    var valueTwo:String?
    var selectedValue:String?
    
    lazy var buttonOne:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("버튼1", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    lazy var buttonTwo:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("버튼2", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    lazy var line:UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
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
        
        addSubview(buttonOne)
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        buttonOne.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonOne.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        buttonOne.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        addSubview(buttonTwo)
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        buttonTwo.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonTwo.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        buttonTwo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonTwo.leftAnchor.constraint(equalTo: buttonOne.rightAnchor).isActive = true
        
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true 
        
    }
    
    // MARK: Selectors
    @objc func buttonTapped(sender:UIButton) {
        switch sender {
        case buttonOne:
            // 현재 선택되어진 value가 valueTwo일때 눌러지면, selectedValue를 valueOne 으로 바꾸어주고,
            // line을 오른쪽으로 움직여준다.
            if selectedValue == valueTwo {
                selectedValue = valueOne
                UIView.animate(withDuration: 0.3) {
                    self.line.transform = CGAffineTransform(translationX: 0 , y: 0)
                }
            }
            break
        case buttonTwo:
            // 현재 선택되어진 value가 valueOne일때 눌러지면, selectedValue를 valueTwo 으로 바꾸어주고,
            // line을 왼쪽으로 움직여준다.
            if selectedValue == valueOne {
                selectedValue = valueTwo
                UIView.animate(withDuration: 0.3) {
                    self.line.transform = CGAffineTransform(translationX: self.line.frame.width, y: 0)
                }
            }
            
            
            break
        default:
            break
        }
    }

}
