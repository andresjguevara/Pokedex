//
//  Pokemon.swift
//  Pokedex
//
//  Created by Andres Guevara Caprio on 8/12/20.
//  Copyright © 2020 Andres Guevara Caprio. All rights reserved.
//

import Foundation

struct Pokemon {
    
    var id : Int
    var name : String
    var image : String
    
    init(id : Int, name : String) {
        self.id = id
        self.name = name
        self.image = "http://img.pokemondb.net/artwork/\(self.name.lowercased().replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "♀", with: "-f").replacingOccurrences(of: "♂", with: "-m")).jpg"
    }
    
}
