//
//  Word.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import Foundation

struct Word {
    let englishWord: String?
    let spanishWord: String?
}

extension Word: Decodable {
    enum CodingKeys: String, CodingKey {
        case englishWord = "text_eng"
        case spanishWord = "text_spa"
    }
}
