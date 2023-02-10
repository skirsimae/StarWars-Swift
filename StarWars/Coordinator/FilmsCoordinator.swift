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
    
    var currentController: FilmsViewController?
    weak var tabBarController: TabBarController?
    
    var networkingService: StarWarsService = StarWarsService.shared
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        
        currentController = FilmsViewController(viewModel: FilmsViewModel(endpoint: .just(.films), service: networkingService))
        currentController?.coordinator = self
        childCoordinators.append(self)
    }
    
    override func start() {
//        currentController.delegate = self
//        self.navigationController.viewControllers = [filmsViewController]
        navigationController?.pushViewController(currentController ?? UIViewController(), animated: true)
    }
}

//extension FilmsCoordinator: FilmsViewControllerDelegate {
//    func navigateToNextPage() {
//        let charactersCoordinator = CharactersCoordinator(navigationController: navigationController)
//        charactersCoordinator.delegate = self
//        childCoordinators.append(charactersCoordinator)
//        charactersCoordinator.start()
//    }
//}
//
//extension FilmsCoordinator: BackToFirstViewControllerDelegate {
//    func navigateBackToFirstPage(newOrderCoordinator: CharactersCoordinator) {
//        navigationController.popToRootViewController(animated: true)
//        childCoordinators.removeLast()
//    }
//}

