//
//  ViewController.swift
//  Pokedex
//
//  Created by Andres Guevara Caprio on 8/12/20.
//  Copyright © 2020 Andres Guevara Caprio. All rights reserved.
//

import UIKit
import CoreData

class PokedexTableViewController: UITableViewController {
    
    var pokemons = [Pokemon]()
    var pokemonsDisplayed = [Pokemon]()
    
    func initializeContent() {
        let fileName = "pokemon_names"
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return }
        guard let pokemons = json as? [Any] else {return }
        for pokemon in pokemons {
            guard let pokemonDict = pokemon as? [String: Any] else {return}
            guard let id = pokemonDict["id"] as? String else {return}
            guard let name = pokemonDict["name"] as? String else {return}
            self.pokemons.append(Pokemon(id:Int(id)!, name:name))
        }
        
        self.pokemonsDisplayed = self.pokemons
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeContent()
        
    }
    
    //MARK: - Tableview Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsDisplayed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        cell.name.text = pokemonsDisplayed[indexPath.row].name
        cell.id.text = "#" + String(format: "%03d", pokemonsDisplayed[indexPath.row].id)
        let url = self.pokemonsDisplayed[indexPath.row].image
        cell.pokemonImage.load(url: URL(string: url)!)
        
        return cell
    }
    
    //MARK: - Tableview Data Methods

}

extension PokedexTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.pokemonsDisplayed = pokemons.filter { (pokemon) -> Bool in
            pokemon.name.lowercased().contains(searchBar.text!.lowercased())
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.pokemonsDisplayed = self.pokemons
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

