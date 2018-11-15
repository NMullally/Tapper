//
//  ViewController.swift
//  Tapper
//
//  Created by Niall Mullally on 04/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

protocol scoreDelegate
{
    func incrementScore()
}

class ViewController: UIViewController
{
    var buttons: [UIButton] = []
    
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var comboLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var gameView: UIView!
    
    var combo: Int = 0
    {
        didSet
        {
            
        }
    }
    
    var score: Int = 0
    {
        didSet
        {
            scoreLabel.text = "\(score)"
        }
    }
    
    var level: Int = 0
    {
        didSet
        {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        GameManager.shared.scoreDelegate = self
        GameManager.shared.gameView = gameView
    
        // Do any additional setup after loading the view, typically from a nib.
        perform(#selector(beginNewLevel), with: nil, afterDelay: 0.1)
        
        score = 0
        
        for _ in 0...20
        {
            createButton()
        }
    }
    
    @objc func beginNewLevel()
    {
        level += 1
        score += 100
        
        self.progressBar.setProgress(1, animated: false)
        
        perform(#selector(startLevel), with: nil, afterDelay: 0.2)
    }
    
    @objc func startLevel()
    {
        
        let animator = UIViewPropertyAnimator(duration: 5, curve: .linear, animations:
        {
            self.progressBar.setProgress(0, animated: true)
            
        })
        animator.addCompletion({_ in self.beginNewLevel()})
        animator.startAnimation()
    }

    func createButton()
    {
        ButtonManager.shared.addButton()
    }
}

extension ViewController : scoreDelegate
{
    func incrementScore()
    {
        score += 100
    }
}
