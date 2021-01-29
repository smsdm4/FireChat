//
//  ChatController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/4/1399 AP.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    private let user: User
    private var messages = [Message]()
    private var fromCurrentUser = false
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        iv.delegate = self
        return iv
    }()
    
    // MARK: - Lifecycles
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var inputAccessoryView: UIView? {
        get { return self.customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        self.collectionView.backgroundColor = .white
        
        // MARK:  NavigationBar
        configureNavigationBar(withTitle: self.user.username , prefersLargeTitles: false)
        
        // MARK: Register CollectionViewCell
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
    }
    
}

// MARK: - Extensions
extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = self.messages[indexPath.row]
        return cell
    }
}

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
}

// MARK: CustomInputaccessoryViewDelegate
extension ChatController: CustomInputaccessoryViewDelegate {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        inputView.messageInputTextView.text = nil
        self.fromCurrentUser.toggle()
        let message = Message(text: message, isFromCurrentUser: self.fromCurrentUser)
        messages.append(message)
        self.collectionView.reloadData()
    }
}
