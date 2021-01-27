//
//  ConversationsController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/25/1399 AP.
//

import UIKit
import Firebase

private let reuseIdentifer = "ConversationsCell"
 
class ConversationsController : UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        return button
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
    }
    
    // MARK: - Selectors
    @objc func showProfile() {
        logout()
    }
    
    @objc func handleShowNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginscreen()
        } else {
            print("DEBUG: User id is \(String(describing: Auth.auth().currentUser?.uid))")
        }
    }
    
    func logout() {
        self.showLoader(true, withText: "Logging Out..")
        do {
            try Auth.auth().signOut()
            self.showLoader(false)
            presentLoginscreen()
        } catch {
            print("DEBUG: Error signing out...")
            self.showLoader(false)
        }
    }
    
    // MARK: - Helpers
    func presentLoginscreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        
        // MARK:  Background
        self.view.backgroundColor = .white
        self.view.overrideUserInterfaceStyle = .light
        
        // MARK:  NavigationBar
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
        let navImage = UIImage(systemName: "person.circle.fill")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: navImage, style: .plain, target: self, action: #selector(showProfile))
        
        // MARK:  TableView
        configureTableView()
        
        self.view.addSubview(self.newMessageButton)
        self.newMessageButton.setDimensions(height: 56, width: 56)
        self.newMessageButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     right: self.view.rightAnchor,
                                     paddingBottom: 24, paddingRight: 24)
        self.newMessageButton.layer.cornerRadius = 56 / 2
        
        // MARK:  Actions
        self.newMessageButton.addTarget(self, action: #selector(handleShowNewMessage), for: .touchUpInside)
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
    }
    
}

// MARK: - TableviewConfigure
extension ConversationsController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        cell.textLabel?.text = "Test Cell" 
        return cell
    }
}

extension ConversationsController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

// MARK: - NewMessageControllerDelegate
extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)
        self.navigationController?.pushViewController(chat, animated: true)
    }
}
