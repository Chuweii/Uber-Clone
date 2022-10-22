//
//  ViewController.swift
//  Uber Clone
//
//  Created by Wei Chu on 2022/10/15.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginBackground:UIImageView = {
       
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "uberbg3")
        
        return imageView
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uber"
        label.font = UIFont.systemFont(ofSize: 37, weight: .medium)
        label.textColor = .systemGreen
        label.textAlignment = .center
        
        return label
    }()
    
    private let userSegment:UISegmentedControl = {
       
        let segment = UISegmentedControl(items: ["Driver","Rider"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 1
        segment.backgroundColor = .systemGreen
        
        return segment
        
    }()
    
    private let emailTextfield:UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email Address"
        textfield.keyboardType = .emailAddress
        textfield.leftViewMode = .always
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
        textfield.leftViewMode = .always
        textfield.isSecureTextEntry = true
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8
        
        return textfield
    }()
    
    private let signInButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign In", for: .normal)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private let signUpButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Create Account", for: .normal)
        
        return button
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginBackground)
        view.addSubview(titleLabel)
        view.addSubview(userSegment)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
                
        configureConstraints()
        
        signUpButton.addTarget(self, action: #selector(tapToCreateAccount), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(tapToSignIn), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginBackground.frame = view.bounds
    }

    
    @objc private func tapToCreateAccount(){
    
        let vc = SignUpViewController()            
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //button sign in action
    @objc private func tapToSignIn(){
        guard let email = emailTextfield.text , !email.isEmpty,
              let password = passwordTextfield.text , !password.isEmpty else {
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            if success{
                DispatchQueue.main.async {
                    let vc = MapViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.navigationBar.prefersLargeTitles = true
                    navVC.modalPresentationStyle = .fullScreen
                    self?.present(navVC, animated: true)
                }
            }else{
                print("account error")
            }
        }
    }
}


//autolauout 設定
extension LoginViewController{
    
    private func configureConstraints(){
        
        let titleLabelConstraints = [
        
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4.7)
        
        ]
        
        let segmentConstraints = [
        
            userSegment.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            userSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userSegment.widthAnchor.constraint(equalToConstant: (view.frame.width / 4) * 2.5),
            userSegment.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let emailTextFieldConstraints = [
        
            emailTextfield.topAnchor.constraint(equalTo: userSegment.bottomAnchor, constant: 40),
            emailTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextfield.widthAnchor.constraint(equalToConstant: (view.frame.width / 5) * 3.6),
            emailTextfield.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        let passwordTextFieldConstraints = [
        
            passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 10),
            passwordTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextfield.widthAnchor.constraint(equalToConstant: (view.frame.width / 5) * 3.6),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        let signInButtonConstraints = [
        
            signInButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 10),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 5) * 3.6),
            signInButton.heightAnchor.constraint(equalToConstant: 30)
            
        ]
        
        let signUpButtonConstraints = [
        
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 5) * 3.6),
            signUpButton.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(segmentConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(signInButtonConstraints)
        NSLayoutConstraint.activate(signUpButtonConstraints)
    }
}

