//
//  AppCoordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxCocoa
import RxSwift

class FilmsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var currentViewController: FilmsListViewController?
    var networkingService: StarWarsService = StarWarsService.shared
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        currentViewController = FilmsListViewController(viewModel: FilmsListViewModel(endpoint: .just(.films), service: networkingService))
    }
    
    func start() {
        if let currentController = currentViewController {
            currentController.tabBarItem = UITabBarItem(title: "Films", image: UIImage(systemName: "popcorn"), tag: 0)
            currentController.coordinator = self
            navigationController.pushViewController(currentController, animated: false)
        }
    }
    
    func showFilmDetails(film: Film) {
        let viewController = filmDetailsViewController(film: film)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func filmDetailsViewController(film: Film) -> FilmDetailsViewController {
        let filmDetailsViewController = FilmDetailsViewController(viewModel: FilmDetailsViewModel(film: film, service: networkingService))
//        filmDetailsViewController.coordinator = self
        
        return filmDetailsViewController
    }
}
