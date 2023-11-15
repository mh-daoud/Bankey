//
//  ViewController.swift
//  Bankey
//
//  Created by admin on 15/11/2023.
//

import UIKit

class LoginViewController: UIViewController {

    lazy var loginView : LoginView = {
        let view = LoginView(frame: .zero)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }

}


extension LoginViewController {
    func style(){
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    }
}
