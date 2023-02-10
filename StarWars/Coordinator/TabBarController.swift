//
//  TabBarController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import UIKit

final class TabBarController: UITabBarController {

    weak var coordinator: MainTabBarCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()


        let navigationController1 = UINavigationController()
        let coordinator1 = FilmsCoordinator(navigationController: navigationController1)
        coordinator1.tabBarController = self
        coordinator1.currentController?.tabBarItem = UITabBarItem(title: "Films",
                                                                  image: nil,
                                                                  tag: 11)

        let navigationController2 = UINavigationController()
        let coordinator2 = CharactersCoordinator(navigationController: navigationController2)
        coordinator2.tabBarController = self
        coordinator2.currentController?.tabBarItem = UITabBarItem(title: "Characters",
                                                                  image: nil,
                                                                  tag: 22)


        viewControllers = [
            coordinator1.currentController!,
            coordinator2.currentController!
        ]

        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = false

    }

    public func requestFromHomeController() {
        print("Home Triggered the function")

        coordinator?.fetchHome(with: "Simple Data",
                               completion: { (dictionary, error) in
                                print("dict from home -> ", dictionary)
        })



    }

    public func requestFromAboutController() {
        print("About Triggered the function")

        coordinator?.handleAbout(with: "Simple Data",
                                 completion: { (dictionary, error) in
                                    print("dict from about -> ", dictionary)
        })
    }
}
