//
//  DummyViewController.swift
//  Bankey
//
//  Created by admin on 18/11/2023.
//

import Foundation


import UIKit


class DummyViewController : UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.text = "Logout"
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: [])
        logoutButton.configuration = .filled()
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        [label, logoutButton].forEach(stackView.addArrangedSubview)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: Actions
extension DummyViewController {
    @objc private func logoutTapped(){
        delegate?.didLogout()
    }
}
