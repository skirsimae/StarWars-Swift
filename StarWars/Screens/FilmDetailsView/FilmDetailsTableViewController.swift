//
//  FilmDetailsTableViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 11/02/2023.
//

import UIKit

class FilmDetailsTableViewController: UITableViewController {
    
    weak var coordinator: FilmsCoordinator?
    let viewModel: FilmDetailsTableViewViewModel
    
    init(viewModel: FilmDetailsTableViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        configureTableView()
        configureCell()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func configureCell() {
        tableView.register(FilmDetailsTableViewCell.nib, forCellReuseIdentifier: FilmDetailsTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailsTableViewCell.identifier, for: indexPath)
        
        guard let cell = cell as? FilmDetailsTableViewCell else { return cell }
        cell.configureWith(viewModel)
    
        return cell
    }
}
