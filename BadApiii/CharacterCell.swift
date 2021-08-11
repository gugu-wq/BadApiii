//
//  CharacterCell.swift
//  BadApiii
//
//  Created by Gugu Ndaba on 2021/07/12.
//

import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterTitleLabel: UILabel!
    
    var character: CharacterStats?
    
    
    func setCharacter(character: CharacterStats) {
        
        //let data = NSData(contentsOf: NSURL(string: "https://www.breakingbadapi.com/api/img")! as URL)
        //characterImageView.image = UIImage(data: data! as Data)
        
        characterTitleLabel.text = character.name
        characterImageView.layer.cornerRadius = characterImageView.frame.size.width/2
        //characterImageView.clipsToBounds = true
    }
    
}
