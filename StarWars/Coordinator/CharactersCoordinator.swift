//
//  CharactersCoordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import UIKit
import RxCocoa
import RxSwift


protocol BackToFirstViewControllerDelegate: AnyObject {
    func navigateBackToFirstPage(newOrderCoordinator: CharactersCoordinator)
}

class CharactersCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    var networkingService: StarWarsService = StarWarsService.shared
    var currentController: CharactersViewController?
    
    weak var delegate: BackToFirstViewControllerDelegate?
    
    init() {
        currentController = CharactersViewController(viewModel: CharactersViewModel(endpoint: .just(.characters), service: networkingService))
        currentController?.coordinator = self
    }
    
    func start() {
        if let currentController = currentController {
            currentController.tabBarItem = UITabBarItem(title: "Films", image: UIImage(systemName: "person"), tag: 0)
            currentController.tabBarItem.tag = 1
            currentController.coordinator = self
            navigationController.pushViewController(currentController , animated: true)
        }
    }
}

