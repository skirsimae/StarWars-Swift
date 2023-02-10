//
//  AppCoordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import UIKit

class FilmsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    var networkingService: NetworkingService = StarWarsNetworkingService()
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let filmsViewController : FilmsViewController = FilmsViewController(viewModel: FilmsViewModel(service: networkingService))
        filmsViewController.delegate = self
        self.navigationController.viewControllers = [filmsViewController]
    }
}

extension FilmsCoordinator: FilmsViewControllerDelegate {
    func navigateToNextPage() {
        let charactersCoordinator = CharactersCoordinator(navigationController: navigationController)
        charactersCoordinator.delegate = self
        childCoordinators.append(charactersCoordinator)
        charactersCoordinator.start()
    }
}

extension FilmsCoordinator: BackToFirstViewControllerDelegate {
    func navigateBackToFirstPage(newOrderCoordinator: CharactersCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}

