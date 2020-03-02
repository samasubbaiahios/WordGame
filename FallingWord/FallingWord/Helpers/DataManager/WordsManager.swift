//
//  WordsManager.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import Foundation

class WordsManager {
    static let shared = WordsManager()
    init() {}
    
    func fetchWords() -> [Word] {
        guard let filePath = Bundle.main.path(forResource: WordFile.fileName, ofType: WordFile.fileExtension) else {
            return []
        }
        do {
            let url = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: url)
            let words = try JSONDecoder().decode([Word].self, from: data)
            return words
        } catch {
            debugPrint(" Error in parsing Json ")
            return []
        }
    }
}
