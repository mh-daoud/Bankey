//
//  LoginView.swift
//  Bankey
//
//  Created by admin on 15/11/2023.
//

import UIKit

class LoginView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var userNameField : UITextField = {
        let textFiled = makeTextField(withPlaceholder: "Username")
        textFiled.delegate = self
        return textFiled
    }()
    
    lazy var passwordField: UITextField = {
        let textField = makeTextField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.enablePasswordToggle()
        return textField
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = makeStackView(axis: .vertical)
        stackView.spacing = 8
        [userNameField,divider, passwordField].forEach(stackView.addArrangedSubview(_:))
        return stackView
    }()
    
    func resetForm(){
        userNameField.text = ""
        passwordField.text = ""
    }
}




extension LoginView {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        self.addRoundedCorner(radius: 5)
    }
    
    func layout(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}


extension LoginView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameField.endEditing(true)
        passwordField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
