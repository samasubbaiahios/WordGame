//
//  Constants.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import Foundation

struct Message {
    static let winMessage = "You Won the Game"
    static let gameFinished = "You've lost the Game!"
    static let gameOverTitle = "Game Over!!"
    static let gameError = "We're sorry, something wrong"
    static let againMsg = "Try again"
}

struct GameProcessValues {
    static let topConstantHeight = 0
    static let animationDuration = 0.75

    static let timeForIteration: Float = 40.0
    static let pointPerQuestion = 1
    static let totalQuestions = 25

    static let highestPoints = 25
    static let leastPoints = 0
    static let refreshFrequency = 0.2
}

enum ResultStatus {
    case Win
    case Loss
    case Error
    case GameOver
}

enum UserInput {
    case True
    case False
}

struct WordFile {
    static let fileName = "words"
    static let fileExtension = "json"
}
