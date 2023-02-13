//
//  CharactersCoordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import RxCocoa
import RxSwift

class CharactersCoordinator: Coordinator {
    var navigationController = UINavigationController()
    var networkingService: StarWarsService = StarWarsService.shared
    var currentController: CharactersViewController?
    
    init() {
        currentController = CharactersViewController(viewModel: CharactersViewModel(service: networkingService))
    }
    
    func start() {
        if let currentController = currentController {
            currentController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 0)
            currentController.tabBarItem.tag = 1
            navigationController.pushViewController(currentController , animated: true)
        }
    }
}

