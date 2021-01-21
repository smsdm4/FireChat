//
//  RegistrationController.swift
//  FireChat
//
//  Created by Mojtaba Mirzadeh on 10/25/1399 AP.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = RegistrationViewModel()
    
    private var profileImg: UIImage?
    
    private let plusPhotobButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "Add-Photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
    }()
    
    private lazy var fullNameContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "Person"), textField: fullNameTextField)
    }()
    
    private lazy var usernameContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "Person"), textField: userNameTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let fullNameTextField: CustomTextField = {
        return CustomTextField(placeholder: "Full Name")
    }()
    
    private let userNameTextField: CustomTextField = {
        return CustomTextField(placeholder: "Username")
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpbButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(height: 50)
        return button
    }()
    
    private let alreayHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributeTitle.append(NSMutableAttributedString(string: "Log In",
                                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Selectors
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        guard let profileImg = self.profileImg else { return }
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        guard let fullname = self.fullNameTextField.text else { return }
        guard let username = self.userNameTextField.text?.lowercased() else { return }
        
        let credentials = RegistrationCredentials(email: email, password: password,
                                                  fullname: fullname, username: username,
                                                  profileImage: profileImg)
        
        self.showLoader(true, withText: "Signing Up..")
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to sign up user with error \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowLogIn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            self.viewModel.email = sender.text
        } else if sender == passwordTextField {
            self.viewModel.password = sender.text
        } else if sender == fullNameTextField {
            self.viewModel.fullname = sender.text
        } else {
            self.viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 80
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    } 
    
    // MARK: - Helpers
    func configureUI() {
        
        // MARK:  Keyboard
        hideKeyboardWhenTappedAround()
        
        // MARK:  Background
        configureGradientLayer()
        
        // MARK:  Add-Image
        self.view.addSubview(self.plusPhotobButton)
        self.plusPhotobButton.centerX(inView: self.view)
        self.plusPhotobButton.setDimensions(height: 150, width: 150)
        self.plusPhotobButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        // MARK:  StackView
        let stack = UIStackView(arrangedSubviews: [self.emailContainerView,
                                                   self.passwordContainerView,
                                                   self.fullNameContainerView,
                                                   self.usernameContainerView,
                                                   self.signUpbButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        self.view.addSubview(stack)
        stack.anchor(top: self.plusPhotobButton.safeAreaLayoutGuide.bottomAnchor,
                     left: self.view.safeAreaLayoutGuide.leftAnchor,
                     right: self.view.safeAreaLayoutGuide.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        self.view.addSubview(alreayHaveAccountButton)
        self.alreayHaveAccountButton.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 32, paddingBottom: 16, paddingRight: 32)
        
        // MARK:  Actions
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.signUpbButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        self.alreayHaveAccountButton.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
    }
    
    func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: - Extensions
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profileImg = image
        self.plusPhotobButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        self.plusPhotobButton.layer.borderColor = UIColor.white.cgColor
        self.plusPhotobButton.layer.borderWidth = 3.0
        self.plusPhotobButton.layer.cornerRadius = self.plusPhotobButton.frame.height / 2
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if self.viewModel.formIsValid {
            self.signUpbButton.isEnabled = true
            self.signUpbButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            self.signUpbButton.isEnabled = false
            self.signUpbButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
