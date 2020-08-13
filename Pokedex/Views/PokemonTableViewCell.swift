//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Andres Guevara Caprio on 8/12/20.
//  Copyright © 2020 Andres Guevara Caprio. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
