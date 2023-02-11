//
//  Coordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }

    func start()
}
