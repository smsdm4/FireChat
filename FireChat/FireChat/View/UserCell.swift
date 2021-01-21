//
//  UserCell.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 11/2/1399 AP.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    var user: User? {
        didSet { configure() }
    }
    
    private let profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "iOS Dev"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "Mojtaba Mirzadeh"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK:  ImageView
        addSubview(profileImgView)
        self.profileImgView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        self.profileImgView.setDimensions(height: 56, width: 56)
        self.profileImgView.layer.cornerRadius = 56 / 2
        
        // MARK:  StackView
        let stack = UIStackView(arrangedSubviews: [self.usernameLabel,
                                                   self.fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 16
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: self.profileImgView.rightAnchor,
                     bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 12, paddingLeft: 10, paddingBottom: 12,
                     paddingRight: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  Helpers
    func configure() {
        guard let user = user else { return }
        
        self.fullnameLabel.text = user.fullname
        self.usernameLabel.text = user.username
        
        guard let url = URL(string: user.profileImageUrl) else { return }
        self.profileImgView.sd_setImage(with: url)
    }
    
}
