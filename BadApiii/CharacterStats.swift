//
//  CharacterStats.swift
//  BadApiii
//
//  Created by Gugu Ndaba on 2021/07/12.
//

import Foundation
import UIKit

struct CharacterStats: Decodable {
    let name: String
    let status: String
    let nickname: String
    let portrayed: String
    let img: String
    
    let occupation: [String]
    let appearance: [Int]
    let birthday: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case name, status, nickname, portrayed, img,
             occupation, appearance, birthday, category
    }
}
