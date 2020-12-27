//
//  ViewControllerExtension.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

extension UIViewController {
    
    
    func handleError(error:Error?, errorMessage:String?, success:Bool) -> Bool {
        if let errorMessage = errorMessage {
            self.presentAlertWithOnlyOkayButton(title: nil, message: errorMessage, handler: nil)
            return false
        }
        if let error = error {
            print("error.localizedDescription:\(error.localizedDescription)")
            self.presentAlertWithOnlyOkayButton(title: nil, message: "현재 서버 네트워크 통신 상황이 좋지 않습니다. 빠른 시일내로 수리하도록 하겠습니다. 죄송합니다 ㅠ_ㅠ", handler: nil)
            return false
        }
        
        if !success {
            self.presentAlertWithOnlyOkayButton(title: nil, message: "현재 서버 네트워크 상태가 좋지 않습니다. 잠시후에 다시 시도해주세요 ㅠ_ㅠ", handler: nil)
            return false
        }
        return true 
    }
    
    func presentAlertWithOnlyOkayButton(title:String?, message:String, handler:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        
        let okayAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: handler)
        alert.addAction(okayAction)
        
        let messageAttributes:[NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
          let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertWithTwoButtons(title:String?, message:String, cancelHandler:((UIAlertAction) -> Void)?, acceptHandler:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: cancelHandler)
        alert.addAction(cancelAction)
        let okayAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: acceptHandler)
        alert.addAction(okayAction)
        
        
        let messageAttributes:[NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
          let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func moveViewHalfWhenKeyboardAppeared() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func dismissKeyboardOutside() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//            tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    
    func clearNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.barTintColor = .systemBackground
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - (keyboardSize.height / 2)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    @objc func pullDownModalHandler(sender: UIPanGestureRecognizer) {
        let translationY = sender.translation(in: sender.view!).y
        

        switch sender.state {
        case .began:
            break
        case .changed:
            view.transform = CGAffineTransform(translationX: 0, y: translationY)
            
            
        case .ended, .cancelled:
            if translationY > 160 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                })
                
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
}
