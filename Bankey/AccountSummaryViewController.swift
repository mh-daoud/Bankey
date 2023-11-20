//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by admin on 19/11/2023.
//

import UIKit
class AccountSummaryViewController : UIViewController {
    
    var accounts = [AccountSummaryCell.ViewModel]()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    func setup(){
        setupTableView()
        setupTableViewHeader()
        fetchData()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTableViewHeader() {
        let header = AccountSummaryHeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    
}

extension AccountSummaryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath) as! AccountSummaryCell
        cell.configure(with: accounts[indexPath.row])
        return cell
    }
}

extension AccountSummaryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    private func fetchData() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                    accountName: "Basic Savings")
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                       accountName: "Visa Avion Card")
        let investment = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver")

        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
    }
}
