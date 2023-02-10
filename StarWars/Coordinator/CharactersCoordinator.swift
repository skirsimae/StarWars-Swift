//
//  CharactersCoordinator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import UIKit

protocol BackToFirstViewControllerDelegate: AnyObject {
    
    func navigateBackToFirstPage(newOrderCoordinator: CharactersCoordinator)
    
}

class CharactersCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator
    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let charactersViewController : CharactersViewController = CharactersViewController()
//        charactersViewController.delegate = self
//        self.navigationController.pushViewController(charactersViewController, animated: true)
    }
}

