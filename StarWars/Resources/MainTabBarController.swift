//
//  MainTabBarController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    let main = FilmsCoordinator()
    let charactersVC = CharactersCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        main.start()
        charactersVC.start()
        viewControllers = [main.navigationController, charactersVC.navigationController]
    }
}
