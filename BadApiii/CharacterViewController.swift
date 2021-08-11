//
//  CharacterViewController.swift
//  BadApiii
//
//  Created by Gugu Ndaba on 2021/07/12.
//

import UIKit

extension UIImageView {
    func fetchUIImage(from url: URL, contentMode mode: ContentMode = .scaleToFill) {
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
    
    func imageDownload(from link: String, contentMode mode: ContentMode = .scaleToFill) {
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
        
        let charactorOcc: [String] = (character?.occupation)!
        let charactorAppearances: [Int] = (character?.appearance)!
        let stringCharactorAppearances = charactorAppearances.map { String($0) }
        
        nameLbl.text = character?.name
        birthLbl.text = character?.birthday
        nicknameLbl.text = character?.nickname
        occupationLbl.text = charactorOcc.joined(separator: ", ")
        statusLbl.text = character?.status
        let livingStatus = character?.status
        switch livingStatus {
        
            case "Alive":
                statusLbl.textColor = .systemBlue
                
            case "Deceased":
                statusLbl.textColor = .red
                
            case "Presumed dead":
                statusLbl.textColor = .orange
                
            default:
                return
        }
        appearanceLbl.text = "Season \(stringCharactorAppearances.joined(separator: ", "))"
        categoryLbl.text = character?.category
        portrayedLbl.text = character?.portrayed
        
        let urlString = (character?.img)!
        
        imageView.imageDownload(from: urlString)
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
}
