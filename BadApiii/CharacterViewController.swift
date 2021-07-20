//
//  CharacterViewController.swift
//  BadApiii
//
//  Created by Gugu Ndaba on 2021/07/12.
//

import UIKit

extension UIImageView
{
    func fetchUIImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func imageDownload(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        fetchUIImage(from: url, contentMode: mode)
    }
}

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var portrayedLabel: UILabel!
    @IBOutlet weak var portrayedLbl: UILabel!
    
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var birthLbl: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var appearanceLabel: UILabel!
    @IBOutlet weak var appearanceLbl: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    
    var character: CharacterStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLbl.text = character?.name
        nicknameLbl.text = character?.nickname
        statusLbl.text = character?.status
        portrayedLbl.text = character?.portrayed
        
        let charactorOcc: [String] = (character?.occupation)!
                let charactorAppearances: [Int] = (character?.appearance)!
                let stringCharactorAppearances = charactorAppearances.map { String($0) }
        appearanceLbl.text = " Seasons \(stringCharactorAppearances.joined(separator: ", "))"
        occupationLbl.text = charactorOcc.joined(separator: ", ")
        birthLbl.text = character?.birthday
        
        let urlString = (character?.img)!
        let url = URL(string: urlString)
        
        imageView.imageDownload(from: urlString)
    }
}
