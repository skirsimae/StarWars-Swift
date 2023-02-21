//
//  CharacterTableViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 12/02/2023.
//

import UIKit
import RxSwift

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configureWith(_ character: Character) {
        switch character {
        case .species(let species):
            nameLabel.text = "Name: \(species.name)"
            birthYearLabel.text = "Classification: \(species.classification)"
            heightLabel.text = "Height: \(species.averageHeight)"
            genderLabel.text = "Average Lifespan: \(species.averageLifespan)"
            
        case .person(let people):
            nameLabel.text = "Name: \(people.name)"
            birthYearLabel.text = "Birth year: \(people.birthYear)"
            heightLabel.text = "Height: \(people.height)"
            genderLabel.text = "Gender: \(people.gender)"
        }
        layoutIfNeeded()
    }
    
}

final class TypeACell: CharacterTableViewCell { }
final class TypeBCell: CharacterTableViewCell { }
