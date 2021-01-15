//
//  ConversationsController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/25/1399 AP.
//

import UIKit

private let reuseIdentifer = "ConversationsCell"
 
class ConversationsController : UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func showProfile() {
        print(123)
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        // MARK:  Background
        self.view.backgroundColor = .white
        self.view.overrideUserInterfaceStyle = .light
        
        // MARK:  NavigationBar
        configureNavigationBar()
        
        // MARK:  TableView
        configureTableView()

    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        self.navigationItem.title = "Messages"
        
        let navImage = UIImage(systemName: "person.circle.fill")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: navImage, style: .plain, target: self, action: #selector(showProfile))
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