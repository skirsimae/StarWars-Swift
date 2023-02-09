//
//  ViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import UIKit

class FilmsViewController: UIViewController {
    private var viewModel: FilmsViewModel = FilmsViewModel()
    private lazy var tableViewConfigurator: FilmsTableViewConfigurator = FilmsTableViewConfigurator(viewModel: viewModel)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .blue
        
        configureTableView()
        
    }
    

    private func configureTableView() {
        tableViewConfigurator.configure(tableView: tableView)
    }
//
//    private func applyViewModel() {
//        bind(to: viewModel)
//    }
}

