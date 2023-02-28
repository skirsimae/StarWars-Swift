//
//  CharacterCollectionViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 27/02/2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with item: Person) {
        self.characterNameLabel.text = item.name
    }
}
