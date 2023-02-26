//
//  LoginViewController.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewの初期設定
        self.initView()
    }
    
    private func initView(){
        userNameTextField.setInputLoginUserName()
        passwordTextField.setInputLoginPassword()
        userNameTextField.addTarget(self, action: #selector(self.inputCheck(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.inputCheck(_:)), for: UIControl.Event.editingChanged)
        signInButton.isEnabled = false
    }
    
    @IBAction func signInAction(_ sender: Any) {
        // APIでログイン処理を実装する
        let storyboad = UIStoryboard(name: R.storyboard.topViewController.name, bundle: nil).instantiateInitialViewController() as! TopViewConroller
        storyboad.modalPresentationStyle = .fullScreen
        self.present(storyboad, animated: true)
    }
    
    // TextFieldの入力チェック
    @objc func inputCheck(_ textField: UITextField){
        // userNameTextField/passwordTextFieldに入力がない場合は抜ける
        guard
            userNameTextField.text != nil, passwordTextField.text != nil,
            userNameTextField.text?.count ?? 0 > 0,passwordTextField.text?.count ?? 0 > 0
        else {
                signInButton.isEnabled = false
                return
        }
        signInButton.isEnabled = true
    }
}
