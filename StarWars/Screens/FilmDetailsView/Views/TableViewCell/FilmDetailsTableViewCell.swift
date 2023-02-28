//
//  FilmDetailsTableViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

import UIKit

class FilmDetailsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(with viewModel: FilmDetailsItemViewModel) {}

}
