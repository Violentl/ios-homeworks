//
//  ProfileViewController.swift
//  Navigation
//
//  Created by User on 07.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.setupNavigationBar()
        self.setUpView()
        tapGesture()
        }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }




    private func setUpView() {

        self.view.addSubview(self.profileHeaderView)

        self.profileHeaderView.backgroundColor = .lightGray

        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)


        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, self.heightConstraint].compactMap({ $0 }))
    }
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 250 : 220

        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}


