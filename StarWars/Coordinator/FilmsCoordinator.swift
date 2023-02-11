//
//  AppCoordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

class FilmsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var currentViewController: FilmsViewController?
    var networkingService: StarWarsService = StarWarsService.shared
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        currentViewController = FilmsViewController(viewModel: FilmsViewModel(endpoint: .just(.films), service: networkingService))
    }
    
    func start() {
        if let currentController = currentViewController {
            currentController.tabBarItem = UITabBarItem(title: "Films", image: UIImage(systemName: "popcorn"), tag: 0)
            currentController.coordinator = self
            navigationController.pushViewController(currentController, animated: false)
        }
    }
    
    func showFilm(film: Film) {
//        let viewController = filmViewController
//        startStudying(using: viewController)
    }
}
