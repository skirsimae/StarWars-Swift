//
//  ViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift
import RxCocoa

public protocol FilmsViewControllerDelegate: AnyObject {
    func navigateToNextPage()
}

class FilmsViewController: UIViewController {
    
    weak var coordinator: FilmsCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    
    public weak var delegate: FilmsViewControllerDelegate?
    
    let viewModel: FilmsViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: FilmsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.films.drive(onNext: {[unowned self] _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.error.drive(onNext: { error in
            print("Error occurred: \(String(describing: error))")
        }).disposed(by: disposeBag)
        
        configureTableView()
        
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(FilmTableViewCell.nib, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FilmsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFilms
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as? FilmTableViewCell else {
            fatalError("xib does not exist")
        }
        
        if let viewModel = viewModel.viewModelForFilm(at: indexPath.row) {
            cell.configureWith(viewModel)
        }

        return cell
    }
}

