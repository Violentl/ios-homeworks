//
//  Setupable.swift
//  Navigation
//
//  Created by User on 16.05.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
