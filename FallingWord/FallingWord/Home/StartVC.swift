//
//  StartVC.swift
//  FallingWord
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var beginButton: UIButton! {
        didSet {
            beginButton.addTarget(self, action: #selector(loadGame), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        let color1 = UIColor(appColor: UIColor.AppColors.blue4)
        let color2 = UIColor(appColor: UIColor.AppColors.green2)
        self.view.setGradientBackground(colorOne: color1, colorTwo: color2)
    }
    fileprivate func setUIStyles() {
        
        appTitle.textColor = UIColor.darkGray
        
        let color1 = UIColor(appColor: UIColor.AppColors.yellow2)
        beginButton.backgroundColor = color1
        beginButton.setTitle("Let's Start", for: .normal)
        beginButton.setTitleColor(UIColor.white, for: .normal)
        beginButton.titleLabel?.font = .systemFont(ofSize: 20)
        beginButton.layer.cornerRadius = 6
    }

    @objc func loadGame() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "gameOn", sender: self)
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "gameOn") {
            // pass data to next view
            let gameView = segue.destination as? GameVC
            gameView?.wordsList = WordsManager.shared.fetchWords()
        }
    }

}
