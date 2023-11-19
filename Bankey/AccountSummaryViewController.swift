//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by admin on 19/11/2023.
//

import UIKit
class AccountSummaryViewController : UIViewController {
    
    let games = [
    "PacMan",
    "Mario Cart",
    "Zelda Xyz"
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    func setup(){
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func style() {
       
    }
    
    func layout() {
        
      
    }
}

extension AccountSummaryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = games[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = game
        cell.contentConfiguration = configuration
        return cell
    }
}

extension AccountSummaryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

