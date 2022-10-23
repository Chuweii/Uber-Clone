//
//  SignUpViewController.swift
//  Uber Clone
//
//  Created by Wei Chu on 2022/10/19.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let headerView = SignHeaderView()

    private let nameTextfield:UITextField = {
        let textfield = UITextField()
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Full Name"
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8
        
        
        return textfield
    }()
    
    private let emailTextfield:UITextField = {
        let textfield = UITextField()
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress
        textfield.leftViewMode = .always
        //取消自動大寫模式
        textfield.autocapitalizationType = .none
        //取消自動校正單字
        textfield.autocorrectionType = .no
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8
        
        
        return textfield
    }()
    
    private let passwordTextfield:UITextField = {
        let textfield = UITextField()
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        textfield.keyboardType = .emailAddress
        textfield.leftViewMode = .always
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.backgroundColor = .secondarySystemBackground
        textfield.isSecureTextEntry = true
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8

        
        return textfield
    }()
    
    private let signUpButton:UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 8
                
        return button
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        //add component
        view.addSubview(headerView)
        view.addSubview(nameTextfield)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(signUpButton)
        
        
        //add button action
        signUpButton.addTarget(self, action: #selector(tapToSignUp), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x:0  , y: view.safeAreaInsets.top , width: view.frame.width, height: view.frame.height / 5)
        
        configureConstraints()
        
    }
    
    //autolayout 設定
    private func configureConstraints(){
        
        let nameTextfieldConstraints = [
            nameTextfield.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            nameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextfield.widthAnchor.constraint(equalToConstant: view.frame.width / 2 + 20),
            nameTextfield.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        let emailTextfieldConstraints = [
            emailTextfield.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 10),
            emailTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextfield.widthAnchor.constraint(equalToConstant: view.frame.width / 2 + 20),
            emailTextfield.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        let passwordTextfieldConstraints = [
            passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 10),
            passwordTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextfield.widthAnchor.constraint(equalToConstant: view.frame.width / 2 + 20),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        let signUpButtonConstraints = [
        
            signUpButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 10),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: passwordTextfield.widthAnchor),
            signUpButton.heightAnchor.constraint(equalTo: passwordTextfield.heightAnchor)
        ]
        

        NSLayoutConstraint.activate(nameTextfieldConstraints)
        NSLayoutConstraint.activate(emailTextfieldConstraints)
        NSLayoutConstraint.activate(passwordTextfieldConstraints)
        NSLayoutConstraint.activate(signUpButtonConstraints)

    }

}

//button sign up action
extension SignUpViewController{
    
    @objc private func tapToSignUp(){
        
        guard let email = emailTextfield.text, !email.isEmpty,
              let password = passwordTextfield.text, !password.isEmpty,
              let name = nameTextfield.text, !name.isEmpty else {
            signUpErrorAlert(title: "Sign up error", message: "Please enter your email and password.")
            return
        }
        
        //create user
        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in
            if success{
                //update database
                let newUser = User(name: name, email: email)
            
                DispatchQueue.main.async {
                    let vc = MapViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.navigationBar.prefersLargeTitles = true
                    navVC.modalPresentationStyle = .fullScreen
                    self?.present(navVC, animated: true)

                }
                
            }else{
                self?.signUpErrorAlert(title: "Sign up error", message: "Please checked email and password adain.")
            }
        }
        
    }
    
    //pop sign up error alert
    private func signUpErrorAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }

    
}
