//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by User on 07.05.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView, UITextFieldDelegate {

    private lazy var imageView: UIImageView = {

        let imageView = UIImageView(image: UIImage(named: "MyPhoto"))
        imageView.layer.borderWidth = 3.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16

        return stackView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rinat Nasipov"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите статус"
        textField.isHidden = true
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica-Regular", size: 15)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.clearButtonMode = .unlessEditing
        textField.clearButtonMode = .always
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitle("Set status", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var buttonTopConstraint: NSLayoutConstraint?

    weak var delegate: ProfileHeaderViewProtocol?

    private func drawSelf() {
        self.addSubview(stackView)
        self.addSubview(textField)
        self.addSubview(setStatusButton)
        self.stackView.addArrangedSubview(imageView)
        self.stackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(fullNameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)
        self.textField.delegate = self

        let stackViewTopConstraint = self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        let avatarImageViewRatioConstraint = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0)

        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let buttonLeadingConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        let buttonBottomConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        NSLayoutConstraint.activate([
            stackViewTopConstraint, stackViewLeadingConstraint,
            stackViewTrailingConstraint, avatarImageViewRatioConstraint,
            self.buttonTopConstraint, buttonLeadingConstraint, buttonTrailingConstraint,
            buttonHeightConstraint, buttonBottomConstraint
        ].compactMap( {$0} ))
    }

    private var statusText: String? = nil

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }

    @objc private func didTapStatusButton() {

        let topTextFieldConstraint = self.textField.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: -10)
        let leadingTextFieldConstraint = self.textField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor)
        let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 40)
        let trailingTextFieldConstraint = self.textField.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)

        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16)

        if self.textField.isHidden {

            self.addSubview(self.textField)
            textField.text = nil
            setStatusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstraint?.isActive = false
            NSLayoutConstraint.activate([topTextFieldConstraint, leadingTextFieldConstraint, trailingTextFieldConstraint, heightTextFieldConstraint, buttonTopConstraint].compactMap( {$0} ))

            textField.becomeFirstResponder()

        } else {
            statusText = textField.text!
            statusLabel.text = "\(statusText ?? "")"
            setStatusButton.setTitle("Show status", for: .normal)

            self.textField.removeFromSuperview()
            NSLayoutConstraint.deactivate([ topTextFieldConstraint, leadingTextFieldConstraint, trailingTextFieldConstraint, heightTextFieldConstraint
            ].compactMap( {$0} ))
        }

        self.delegate?.didTapStatusButton(textFieldIsVisible: self.textField.isHidden) { [weak self] in
            self?.textField.isHidden.toggle()
        }
    }
}

