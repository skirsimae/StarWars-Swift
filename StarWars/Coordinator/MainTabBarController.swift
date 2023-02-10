//
//  MainTabBarController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    var currentController: TabBarController?
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)

        self.currentController = TabBarController()
        self.addChildCoordinator(self)
        currentController?.coordinator = self
    }
    
    override func start() {
        
        navigationController?.pushViewController(currentController ?? UIViewController(), animated: true)
        
    }
    
    func fetchHome(with title: String, completion:  @escaping (_ result: Dictionary<String,Any>, _ error: NSError?) -> ()) {
        
        completion(["ss":"ss"], nil)
        
    }
    
    
    func handleAbout(with title: String, completion: @escaping (_ result: Dictionary<String,Any>, _ error: NSError?) -> ()) {
        
        completion(["ss":"ss"], nil)
    }
}
