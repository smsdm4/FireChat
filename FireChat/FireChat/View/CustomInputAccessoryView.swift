//
//  CustomInputAccessoryView.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/5/1399 AP.
//

import UIKit

protocol CustomInputaccessoryViewDelegate: class {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    weak var delegate: CustomInputaccessoryViewDelegate?
    
    let messageInputTextView: UITextView = {
       let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.overrideUserInterfaceStyle = .light
        return tv
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemPurple, for: .normal)
        return button
    }()
    
    private let placeholderLabel: UILabel = {
       let label = UILabel()
        label.text = "Enter Message Here..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = .flexibleHeight
        configureNotificationObservers()
        
        // MARK: Layer Setting
        self.backgroundColor = .white
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .init(width: 0, height: -8)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        self.sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 8)
        self.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        self.messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
                                         right: self.sendButton.leftAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 8, paddingRight: 8)
        
        addSubview(placeholderLabel)
        self.placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        self.placeholderLabel.centerY(inView: messageInputTextView)
        
        // MARK:  Actions
        self.sendButton.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        
    }
    
    func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleSendMessage() {
        guard let text = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: text)
    }
    
    @objc func handleTextInputChange() {
        self.placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
}
