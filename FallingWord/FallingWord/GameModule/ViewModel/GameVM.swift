//
//  GameVM.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import UIKit
import AudioToolbox

protocol GameProcessorDelegate : NSObjectProtocol{
    func timePassed(timeLeft: Float)
    func gameFinished(result: String)
}

class GameVM: NSObject {
    weak var delegate: GameProcessorDelegate?
    
    private var scoreLabel: UILabel!
    private var mainLabel: UILabel!
    private var translationLabel: UILabel!
    
    private var mainTimer: Timer!
    private var score: Int = 0
    private var totalIterations: Int = 0
    
    private var timeLeft = GameProcessValues.timeForIteration
    
    private var wordfullList: [Word]?
    private var currentWord: GameWord?
    private var currentTranslation: GameWord?
    
    //MARK: Public methods
    func startGame(targetLabel: UILabel, topLabel: UILabel, scoreBoard: UILabel, wordList: [Word]) {
        currentWord = GameWord()
        currentTranslation = GameWord()
        wordfullList = wordList
        scoreLabel = scoreBoard
        translationLabel = topLabel
        mainLabel = targetLabel
        mainTimer = Timer.scheduledTimer(timeInterval: GameProcessValues.refreshFrequency, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
        restartIteration()
    }
    
    func react(input: UserInput){
        vibrate()
        let isCorrectTranslation: Bool = (currentWord?.spanish == currentTranslation?.spanish)
        if input == .True {
            if isCorrectTranslation == true {
                incrementScore()
                return
            }
        } else {
            if isCorrectTranslation == false {
                incrementScore()
                return
            }
        }
        restartIteration()
        //decrementScore()
    }
    
    @objc private func incrementTime(){
        timeLeft -= 1
        if timeLeft == 0 {
            restartIteration()
            //decrementScore()
        }
        delegate?.timePassed(timeLeft: timeLeft)
    }
    
    //MARK: Increments & decrements
    private func endGame(result : ResultStatus){
        vibrate()
        var message : String
        switch result {
        case .Win:
            message = Message.winMessage
        case .Loss:
            message = Message.gameFinished
        case .GameOver:
            message = Message.gameOverTitle
        default:
            message = Message.gameError
        }
        delegate?.gameFinished(result: message)
        mainTimer.invalidate()
    }
    
    private func incrementScore(){
        score += GameProcessValues.pointPerQuestion
        restartIteration()
    }
    
    private func decrementScore(){
        score -= GameProcessValues.pointPerQuestion
        restartIteration()
    }
    
    //MARK: Iteration managment
    private func restartIteration() {
        scoreLabel.text = String(score)
        if score == GameProcessValues.highestPoints {
            endGame(result: ResultStatus.Win)
            return
        }
        if totalIterations == GameProcessValues.totalQuestions {
            if score == GameProcessValues.leastPoints {
                endGame(result: ResultStatus.Loss)
                return
            }
            endGame(result: ResultStatus.GameOver)
            return
        }
        timeLeft = GameProcessValues.timeForIteration
        mainLabel.text = targetWord()
        translationLabel.text = translationWord()
        totalIterations += 1
    }
    
    //MARK: Word managment
    private func targetWord() -> String {
        let fullSize = wordfullList?.count
        let nthElement = Int(arc4random_uniform(UInt32(fullSize ?? 0)))
        if let fullList = wordfullList {
            let random = fullList[nthElement]
            currentWord?.english = random.englishWord ?? ""
            currentWord?.spanish = random.spanishWord ?? ""
            let displayStr = currentWord?.english
            return displayStr?.capitalized ?? ""
            
        }
        //Something went wrong, ending game with error
        endGame(result: ResultStatus.Error)
        return ""
    }
    
    private func translationWord() -> String{
        let fullSize = wordfullList?.count
        let nthElement = Int(arc4random_uniform(UInt32(fullSize ?? 0)))
        
        if let fullList = wordfullList {
            if nthElement % 2 == 0{
                currentTranslation = currentWord
            } else {
                let random = fullList[nthElement]
                currentTranslation?.english = random.englishWord ?? ""
                currentTranslation?.spanish = random.spanishWord ?? ""
            }
            let displayStr = currentTranslation?.spanish
            return displayStr?.capitalized ?? ""
        }
        return ""
    }
    
    //MARK: Feedback
    
    private func vibrate(){
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
}
