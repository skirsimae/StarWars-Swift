//
//  FilmsListViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift
import RxCocoa

class FilmsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var coordinator: FilmsCoordinator?
    let viewModel: FilmsListViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: FilmsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Films"
        
        configureTableViewCell()
        configureTableView()
        handleTableViewCellSelection()
        handleShowingError()
    }
    
    private func configureTableViewCell() {
        viewModel.films.drive(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        //TODO: show error
        viewModel.error.drive(onNext: { error in
            print("Error occurred: \(String(describing: error))")
        }).disposed(by: disposeBag)
        
        
        viewModel._films.asObservable().bind(to: tableView
            .rx
            .items(cellIdentifier: FilmTableViewCell.identifier, cellType: FilmTableViewCell.self)) {
                (row, element, cell) in
                if let viewModel = self.viewModel.viewModelForFilm(at: row) {
                    cell.configureWith(viewModel)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func handleTableViewCellSelection() {
        tableView.rx
            .modelSelected(Film.self)
            .asDriver()
            .drive(onNext: { [unowned self] film in
                self.coordinator?.showFilm(film: film)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleShowingError() {
        viewModel.error.drive(onNext: {[unowned self] (error) in
            self.errorLabel.isHidden = !self.viewModel.hasError
            self.errorLabel.text = error
        })
        .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(FilmTableViewCell.nib, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func showFilm(film: Film) {
        coordinator?.showFilm(film: film)
    }
}
