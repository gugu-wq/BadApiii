//
//  CharacterListScreen.swift
//  BadApiii
//
//  Created by Gugu Ndaba on 2021/07/12.
//

import UIKit


/*----- REMEMBER TO ADD BACKING CLASS FOR TABLE VIEW, THINK IT SHOULD BE characterListScreen------*/

class CharacterListScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characters = [CharacterStats]() /*---- ARRAY OF CHARACTERS NEEDED FOR CELL VIEW ----*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as!
        CharacterCell
        
        cell.setCharacter(character: character)
        cell.characterImageView.imageDownload(from: (characters[indexPath.row].img))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterViewController {
            destination.character = characters[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://www.breakingbadapi.com/api/characters")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.characters = try JSONDecoder().decode([CharacterStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}
