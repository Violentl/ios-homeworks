//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by User on 07.05.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func buttonAction()
    
    func delegateActionAnimatedAvatar(cell: ProfileHeaderView)
}

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    
    private var statusText: String?
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "MyPhoto"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70.0
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text  = "Rinat Nasipov"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12.0
        textField.placeholder = "Введите статус..."
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {  // КНОПКА
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonAction),
                         for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shouldRasterize = true
        button.layer.shadowPath =  UIBezierPath(rect: button.bounds).cgPath
        
        return button
    }()
    
    weak var delegate: ProfileHeaderViewProtocol? // ДЕЛЕГАТ НАЖАТИЯ
    
    private var tapGestureRecognizer = UITapGestureRecognizer() // НАЖАТИЕ НА АВАТАР
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createSubviews() {
        self.addSubview(self.mainStackView)
        self.mainStackView.addArrangedSubview(self.avatarImageView)
        self.mainStackView.addArrangedSubview(self.labelStackView)
        self.labelStackView.addArrangedSubview(self.fullNameLabel)
        self.labelStackView.addArrangedSubview(self.statusLabel)
        self.addSubview(self.statusTextField)
        self.addSubview(self.setStatusButton)
        self.setupConstraints()
        self.setupTapGesture()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 138),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 138),
            
            self.statusTextField.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: -10),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.labelStackView.trailingAnchor),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func buttonAction() {
        guard statusTextField.text != "" else {
            statusTextField.vibrate()
            return
        }
        statusText = self.statusTextField.text!
        statusLabel.text = "\(statusText ?? "")"
        self.statusTextField.text = nil
        self.endEditing(true)
    }
}


extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}

extension ProfileHeaderView: UIGestureRecognizerDelegate {
    
    private func setupTapGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatarImageView.addGestureRecognizer(self.tapGestureRecognizer)
        self.avatarImageView.isUserInteractionEnabled = true
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        delegate?.delegateActionAnimatedAvatar(cell: self)
    }
}


extension UIView {
    func vibrate() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.05
    animation.repeatCount = 5
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
    layer.add(animation, forKey: "position")
    }
}

