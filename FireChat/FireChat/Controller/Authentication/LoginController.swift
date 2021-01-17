//
//  LoginController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/25/1399 AP.
//

import UIKit

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

class LoginController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
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
        button.isEnabled = false
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
        tf.keyboardType = .emailAddress
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
        return button
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleLogin() {
        //Handle Login Here
    }
    
    @objc func handleShowSignUp() {
        let signUpController = RegistrationController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == self.emailTextField {
            self.viewModel.email = sender.text
        } else {
            self.viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        // MARK:  Keyboard
        hideKeyboardWhenTappedAround()
        
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
        
        // MARK:  Actions
        self.logibButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        self.dontHaveAccountButton.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
    }
    
}

// MARK:  Extensions
extension LoginController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if self.viewModel.formIsValid {
            self.logibButton.isEnabled = true
            self.logibButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            self.logibButton.isEnabled = false
            self.logibButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
