//
//  LoginController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/25/1399 AP.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private let iconeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
    }()
    
    private let logibButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(height: 50)
        return button
    }()
    
    private let emailTextField: CustomTextField = {
       let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
       let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Don't have an account? ",
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributeTitle.append(NSMutableAttributedString(string: "Sign Up",
                                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleShowSignUp() {
        let signUpController = RegistrationController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        // MARK:  Background
        configureGradientLayer()
        
        // MARK:  NavigationBar
        configureNavigationBar()
        
        // MARK:  Image
        self.view.addSubview(self.iconeImage)
        self.iconeImage.centerX(inView: self.view)
        self.iconeImage.setDimensions(height: 120, width: 120)
        self.iconeImage.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        // MARK:  StackView
        let stack = UIStackView(arrangedSubviews: [self.emailContainerView,
                                                   self.passwordContainerView,
                                                   self.logibButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        self.view.addSubview(stack)
        stack.anchor(top: self.iconeImage.safeAreaLayoutGuide.bottomAnchor,
                     left: self.view.safeAreaLayoutGuide.leftAnchor,
                     right: self.view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        self.view.addSubview(dontHaveAccountButton)
        self.dontHaveAccountButton.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 32, paddingBottom: 16, paddingRight: 32)
        
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = self.view.frame
        self.view.layer.addSublayer(gradient)
    }
    
}
