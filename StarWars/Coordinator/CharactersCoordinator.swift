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
    
    var networkingService: StarWarsService = StarWarsService.shared
    
    var currentController: CharactersViewController?
    weak var tabBarController: TabBarController?
    
    weak var delegate: BackToFirstViewControllerDelegate?
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        
        currentController = CharactersViewController(viewModel: CharactersViewModel(endpoint: .just(.characters), service: networkingService))
        currentController?.coordinator = self
        childCoordinators.append(self)
    }
    
    override func start() {
        navigationController?.pushViewController(currentController ?? UIViewController(), animated: true)
    }
}

