//
//  LoginScreenViewController.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 22.02.2021.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    //MARK: Property
    
    let imageView = UIImageView(image: UIImage(named: "imageBackground"))
    let loginTextField =  UITextField()
    let passwordTextField =  UITextField()
        
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame = UIScreen().bounds
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        setupTextField()
        createdLoginLabel()
        
    }

    
}

extension LoginScreenViewController: UITextFieldDelegate {
    
}

//MARK: File private functions

fileprivate extension LoginScreenViewController {
    
     func setupTextField(){
        loginTextField.placeholder = "name@email.domen"
        loginTextField.font = UIFont.systemFont(ofSize: 17)
        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.keyboardType = UIKeyboardType.emailAddress
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginTextField.clearsOnBeginEditing = true
        loginTextField.clearsContextBeforeDrawing = true
        loginTextField.delegate = self
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        
        passwordTextField.placeholder = "••••••••"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearsContextBeforeDrawing = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        
        loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
     
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 45
        ).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor).isActive = true
    }
    
    func createdLoginLabel() {
        let welcomeLabel = UILabel()
        welcomeLabel.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        welcomeLabel.text = "Welcome"
        welcomeLabel.textColor = .white
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        let labelLogin = UILabel()
        labelLogin.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        labelLogin.textColor = .white
        labelLogin.text = "Login"
        labelLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelLogin)

        let labelPassword = UILabel()
        labelPassword.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        labelPassword.textColor = .white
        labelPassword.text = "Password"
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelPassword)
        
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        labelLogin.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -5).isActive = true
        
        labelPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        labelPassword.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15).isActive = true
    }
    
}
