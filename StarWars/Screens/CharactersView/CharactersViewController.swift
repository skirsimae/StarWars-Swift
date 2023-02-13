//
//  CharactersViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import RxSwift
import RxCocoa

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var charactersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: CharactersViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        configureTableViewCell()
        configureTableView()
    }
    
    
    private func configureTableViewCell() {
        viewModel.selectedCharacterType.asObservable().subscribe(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        //TODO: show error
        viewModel.error.drive(onNext: { error in
            print("Error occurred: \(String(describing: error))")
        }).disposed(by: disposeBag)
        
        viewModel.people.asObservable().bind(to: tableView.rx.items) { (tableView, row, people) -> UITableViewCell in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier,
                                     for: IndexPath(row: row, section: 0)) as! CharactersTableViewCell
            cell.configureWith(.person(people))
            
            return cell
        }
        .disposed(by: disposeBag)
        
        //TODO: manage reusing the tableView cell for species
        //  viewModel.people.asObservable().bind(to: tableView.rx.items) { (tableView, row, species) -> }
        
        charactersSegmentedControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe{ [self] _ in
                switch charactersSegmentedControl.selectedSegmentIndex {
                case 0: viewModel._selectedCharacterType.accept(.person)
                case 1:  viewModel._selectedCharacterType.accept(.species)
                default: break
                }
            }
            .disposed(by: disposeBag)
        
        viewModel._selectedCharacterType.asObservable().subscribe { [unowned self] character in
            self.viewModel.fetchCharacter()
        }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(CharactersTableViewCell.nib, forCellReuseIdentifier: CharactersTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}
