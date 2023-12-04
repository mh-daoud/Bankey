//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by admin on 19/11/2023.
//

import UIKit
class AccountSummaryViewController : UIViewController {
    
    //Request Models
    var profile: Profile?
    var accounts: [Account] = []
    
    //View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels = [AccountSummaryCell.ViewModel]()
    
    //Components
    let tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    func setup(){
        setupNavigationBar()
        setupTableView()
        setupTableViewHeader()
        setupRefreshControl()
        fetchData()
    }
    
    private func setupTableView(){
        tableView.backgroundColor = Theme.appColor
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
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func setupRefreshControl(){
        refreshControl.tintColor = Theme.appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension AccountSummaryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath) as! AccountSummaryCell
        cell.configure(with: accountCellViewModels[indexPath.row])
        return cell
    }
}

extension AccountSummaryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        let userId = String(Int.random(in: 1..<4))
        group.enter()
        fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure(let error):
                print("fetch accounts error \(error.localizedDescription)")
            }
            group.leave()
        }
        
        group.notify(queue: .main){
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map({
            AccountSummaryCell.ViewModel.init(accountType: $0.type,
                                              accountName: $0.name,
                                              balance: $0.amount)
        })
    }
}


// MARK: Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        fetchData()
    }
}
