//
//  ViewController.swift
//  Bankey
//
//  Created by admin on 15/11/2023.
//

import UIKit

protocol LogoutDelegate : AnyObject {
    func didLogout()
}


protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    lazy var appTitle : UILabel = {
        let label = makeLabel(withText: "Bankey")
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var appDescription : UILabel = {
        let label = makeLabel(withText: "Your premium source for all things banking!")
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var loginView : LoginView = {
        let view = LoginView(frame: .zero)
        return view
    }()
    
    lazy var signInButton : UIButton = {
        let button = makeButton(withTitle: "Sign In")
        button.backgroundColor = .systemBlue
        button.addRoundedCorner(radius: 5)
        button.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        return button
    }()
    
    lazy var errorMessage : UILabel = {
        let label = makeLabel(withText: "")
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var username : String? {
        return loginView.userNameField.text
    }
    
    var password : String? {
        return loginView.passwordField.text
    }
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.signInButton.configuration?.showsActivityIndicator = false
        loginView.resetForm()
    }
}


extension LoginViewController {
    func style(){
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        
        [appTitle,appDescription,loginView,signInButton, errorMessage].forEach(view.addSubview(_:))
        
        //App Title Label
        NSLayoutConstraint.activate([
            appDescription.topAnchor.constraint(equalToSystemSpacingBelow: appTitle.bottomAnchor, multiplier: 3),
            appTitle.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //App Description Label
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescription.bottomAnchor, multiplier: 3),
            appDescription.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appDescription.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //Login View
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //SignIn Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //Error Message Label
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessage.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}


extension LoginViewController {
    @objc func signInTapped() {
        errorMessage.isHidden = true
        login()
    }
    
    private func login() {
        signInButton.configuration?.showsActivityIndicator = true
        delegate?.didLogin()
        return
        guard let username, let password else {
            assertionFailure("Username / Password should never be nil!")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }
        else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message : String) {
        errorMessage.isHidden = false
        errorMessage.text = message
    }
}
