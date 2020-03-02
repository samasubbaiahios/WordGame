//
//  GameVC.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    var gameMonitor = GameVM()
    var wordsList: [Word]?
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var topWordConstraint: NSLayoutConstraint!
    @IBOutlet weak var translatedLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton! {
        didSet {
            trueButton.addTarget(self, action: #selector(correctWordSelection), for: .touchUpInside)
        }
    }
    @IBOutlet weak var falseButton: UIButton!{
        didSet {
            falseButton.addTarget(self, action: #selector(wrongWordSelection), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameMonitor.delegate = self
        gameMonitor.startGame(targetLabel: targetLabel, topLabel: translatedLabel, scoreBoard: scoreLabel, wordList: wordsList ?? [])
        setUIStyles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super .viewWillTransition(to: size, with: coordinator)
        coordinator .animate(alongsideTransition: { (context) in
            self.setupUI()
            self.view.layoutIfNeeded()
        }, completion: { (context) in
        })
    }
    
    fileprivate func setupUI() {
        let color1 = UIColor(appColor: UIColor.AppColors.green4)
        let color2 = UIColor(appColor: UIColor.AppColors.purple1)
        self.view.setGradientBackground(colorOne: color1, colorTwo: color2)
    }
    
    fileprivate func setUIStyles() {
        
        targetView.layer.cornerRadius = 8
        targetView.layer.borderWidth = 2
        targetView.layer.borderColor = UIColor(appColor:UIColor.AppColors.grey).cgColor
        
        translatedLabel.font = .systemFont(ofSize: 30)
        translatedLabel.textColor = UIColor(appColor:UIColor.AppColors.purple)
        
        targetLabel.font = .systemFont(ofSize: 30)
        targetLabel.textColor = UIColor(appColor:UIColor.AppColors.orange)

        scoreLabel.textColor = UIColor.darkGray
        scoreLabel.font = .systemFont(ofSize: 20)
        
    }
    
    @objc func correctWordSelection() {
        gameMonitor.react(input: UserInput.True)
    }
    @objc func wrongWordSelection() {
        gameMonitor.react(input: UserInput.False)
    }
}

extension GameVC: GameProcessorDelegate {
    func timePassed(timeLeft: Float){
        var value = self.view.frame.height - CGFloat(Float(self.view.frame.height) * (timeLeft / GameProcessValues.timeForIteration))
        if timeLeft == 0 {
            value = CGFloat(GameProcessValues.topConstantHeight)
        }
        UIView.animate(withDuration: GameProcessValues.animationDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: {
            DispatchQueue.main.async {
                self.topWordConstraint.constant = value
                self.view.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    func gameFinished(result: String){
        let alert = UIAlertController(title: nil, message: result, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Message.againMsg, style: .default, handler: { [unowned self] (alert) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
