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
        currentController = CharactersViewController(viewModel: CharactersViewModel(endpoint: .just(.people), service: networkingService))
    }
    
    func start() {
        if let currentController = currentController {
            currentController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 0)
            currentController.tabBarItem.tag = 1
            navigationController.pushViewController(currentController , animated: true)
        }
    }
}

