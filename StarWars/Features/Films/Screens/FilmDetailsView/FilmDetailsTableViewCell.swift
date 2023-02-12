//
//  FilmViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 11/02/2023.
//

import UIKit

class FilmDetailsTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var episodeDetailLabel: UILabel!
    @IBOutlet weak var peopleDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(_ viewModel: FilmViewModel) {
        episodeDetailLabel.text = "Episode: \(viewModel.episode)"
        peopleDetailLabel.text = "People: \(viewModel.characters.joined())"
        layoutIfNeeded()
    }
}
