//
//  InputContainerView.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/26/1399 AP.
//

import UIKit

class InputContainerView: UIView {
    
    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)
        
        setHeight(height: 50)
        backgroundColor = .clear
        
        // MARK:  imageView
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white

        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 28, width: 28)
        
        // MARK:  TextField
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: iv.rightAnchor,
                         right: rightAnchor,
                         paddingLeft: 8,
                         paddingRight: 8)
        textField.setHeight(height: 28)
        
        // MARK:  DeviderView
        let deviderView = UIView()
        deviderView.backgroundColor = .white
        
        addSubview(deviderView)
        deviderView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                           paddingLeft: 8, paddingBottom: 0, paddingRight: 8,
                           height: 0.75)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
