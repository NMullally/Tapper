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
    func incrementScore(amount: Int)
}

class ViewController: UIViewController
{
    var buttons: [UIButton] = []
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var comboLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var countdownView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var combo: Int = 0
    {
        didSet
        {
            UIView.animate(withDuration: 0.6, animations:
                {
                    self.comboLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
                , completion: { _ in
                    self.comboLabel.transform = CGAffineTransform.identity
            })
            
            comboLabel.text = "x:\(combo)"
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
        perform(#selector(startGame), with: nil, afterDelay: 0.1)
        
        score = 0
        self.progressBar.setProgress(1, animated: false)
        countdownLabel.text = "\(GameManager.GameDetails.StartTimer)"
    }
    
    // MARK: Levels
    @objc func nextLevel()
    {
        level += 1
        score += 100
        self.progressBar.setProgress(1, animated: false)
        
        GameManager.shared.clearButtons()
        
        perform(#selector(startLevel), with: nil, afterDelay: 0.2)
    }
    
    @objc func startLevel()
    {
        UIView.animate(withDuration: 0.5, animations:
            {
                self.countdownView.alpha = 0
                self.countdownLabel.alpha = 0
                
        }, completion:
            { _ in
                
                GameManager.shared.spawnButtons()
                
                let animator = UIViewPropertyAnimator(duration: 5, curve: .linear, animations:
                {
                    self.progressBar.setProgress(0, animated: true)
                    
                })
                animator.addCompletion({_ in self.nextLevel()})
                animator.startAnimation()
        })
    }
    
    // MARK: Start Game
    
    @objc func startGame()
    {
        perform(#selector(preformCountdown),
                with: NSNumber(integerLiteral: GameManager.GameDetails.StartTimer),
                afterDelay: 0.0)
    }
    
    @objc func preformCountdown(nsDuration: NSNumber)
    {
        let duration : Int = nsDuration.intValue
        countdownLabel.text = "\(duration)"

        let currentDur = duration - 1
        
        if currentDur <= 0
        {
            perform(#selector(startLevel), with: nil, afterDelay: 1.0)
        }
        else
        {
            perform(#selector(preformCountdown), with: currentDur, afterDelay: 1.0)
        }
        
        let animation: CATransition = CATransition()
        animation.duration = 1.0
        animation.type = CATransitionType.moveIn
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        countdownLabel.layer.add(animation, forKey: "changeTextTransition")
        countdownLabel.text = "\(currentDur)"
    }
}

extension ViewController : scoreDelegate
{
    func incrementScore(amount: Int)
    {
        combo = amount > 0 ? combo + 1 : 0
        score += amount
    }
}
