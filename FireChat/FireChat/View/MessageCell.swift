//
//  MessageCell.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/6/1399 AP.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    var message: Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.overrideUserInterfaceStyle = .light
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let bc = UIView()
        bc.backgroundColor = .systemPurple
        return bc 
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(self.profileImgView)
        self.profileImgView.anchor(left: leftAnchor, bottom: bottomAnchor,
                                   paddingLeft: 8, paddingBottom: -4)
        self.profileImgView.setDimensions(height: 32, width: 32)
        self.profileImgView.layer.cornerRadius = 32 / 2
        
        addSubview(self.bubbleContainer)
        self.bubbleContainer.anchor(top: topAnchor)
        self.bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        self.bubbleContainer.layer.cornerRadius = 12 / 2
        
        self.bubbleLeftAnchor = self.bubbleContainer.leftAnchor.constraint(equalTo: self.profileImgView.rightAnchor, constant: 12 )
        self.bubbleLeftAnchor.isActive = false
        self.bubbleRightAnchor = self.bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12 )
        self.bubbleRightAnchor.isActive = false
        
        addSubview(self.textView)
        self.textView.anchor(top: self.bubbleContainer.topAnchor, left: self.bubbleContainer.leftAnchor,
                             bottom: self.bubbleContainer.bottomAnchor, right: self.bubbleContainer.rightAnchor,
                             paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configure() {
        guard let message = self.message else { return }
        let viewModel = MessageViewModel(message: message)
        
        self.bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        self.textView.textColor = viewModel.messageTextColor
        self.textView.text = message.text
        
        self.bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        self.bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        
        self.profileImgView.isHidden = viewModel.shouldHideProfileImage
    }
    
}
