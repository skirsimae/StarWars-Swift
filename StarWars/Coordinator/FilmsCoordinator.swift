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
    
    func showFilm(film: Film) {
        let viewController = filmTableViewController(film: film)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func filmTableViewController(film: Film) -> FilmDetailsTableViewController{
        let filmDetailsTableViewController = FilmDetailsTableViewController(viewModel: FilmDetailsTableViewViewModel(film: film, endpoint: .just(.people), service: networkingService))
        filmDetailsTableViewController.coordinator = self
        
        return filmDetailsTableViewController
    }
}
