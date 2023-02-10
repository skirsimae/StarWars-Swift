//
//  CharactersViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import RxSwift
import RxCocoa

class CharactersViewController: UIViewController {
    
    weak var coordinator: CharactersCoordinator?
    
    let tableView = UITableView()
    
    let viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

    }

}
