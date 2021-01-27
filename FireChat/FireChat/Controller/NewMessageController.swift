//
//  NewMessageController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/1/1399 AP.
//

import UIKit

private let reuseIdentifer = "NewMessageCell"

protocol NewMessageControllerDelegate: class {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var users = [User]()
    
    weak var delegate: NewMessageControllerDelegate?
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    // MARK: - Selectores
    @objc func handleDismissal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    func fetchUsers() {
        Service.shared.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        // MARK:  Background
        self.view.overrideUserInterfaceStyle = .light
        
        // MARK:  NavigationBar
        configureNavigationBar(withTitle: "New Messages", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        // MARK:  configureTableV iew
        configureTableView()
        
    }
    
    func configureTableView() {
        self.tableView.backgroundColor = .white
        self.tableView.frame = self.view.frame
        self.tableView.rowHeight = 80
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
    }
    
}

// MARK: - TableviewConfigure
extension NewMessageController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
        cell.user = self.users[indexPath.row]
        return cell
    }
} 

extension NewMessageController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.controller(self, wantsToStartChatWith: self.users[indexPath.row])
    }
}
