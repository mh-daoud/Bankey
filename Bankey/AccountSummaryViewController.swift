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
    
    //Networking
    var profileManager : ProfileManageable = ProfileManager()
    
    //Error alert
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    var isLoaded = false
    
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
        setupSkeletons()
        fetchData()
    }
    
    private func setupTableView(){
        tableView.backgroundColor = Theme.appColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseIdentifier)
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
    
    func setupSkeletons() {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
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
        if isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath) as! AccountSummaryCell
            cell.configure(with: accountCellViewModels[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseIdentifier, for: indexPath) as! SkeletonCell
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
        
        // Testing - random number selection
        let userId = String(Int.random(in: 1..<4))
        
        fetchProfile(group: group, userId: userId)
        fetchAccounts(group: group, userId: userId)
        
        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    private func fetchProfile(group: DispatchGroup, userId: String) {
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    private func fetchAccounts(group: DispatchGroup, userId: String) {
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    private func reloadView() {
        self.tableView.refreshControl?.endRefreshing()
        
        guard let profile = self.profile else { return }
        
        self.isLoaded = true
        self.configureTableHeaderView(with: profile)
        self.configureTableCells(with: self.accounts)
        self.tableView.reloadData()
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
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true, completion: nil)
    }
    
    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }
    
    private func titleAndMessage(for error: NetworkError) -> (String,String) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        }
        return (title,message)
    }
}


// MARK: Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        reset()
        self.setupSkeletons()
        self.tableView.reloadData()
        fetchData()
    }
    
    private func reset(){
        profile = nil
        accounts = []
        isLoaded = false
    }
}


// MARK: Unit testing
extension AccountSummaryViewController {
    func titleAndMessageForTesting(for error: NetworkError) -> (String,String) {
        return titleAndMessage(for: error)
    }
    
    func fetchProfileForTesting() {
        fetchProfile(group: DispatchGroup(), userId: "1")
    }

}
