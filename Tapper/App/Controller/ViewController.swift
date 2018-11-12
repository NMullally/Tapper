//
//  ViewController.swift
//  Tapper
//
//  Created by Niall Mullally on 04/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let kButtonSize = CGSize(width: 50, height: 50)
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
        // Do any additional setup after loading the view, typically from a nib.
        perform(#selector(beginNewLevel), with: nil, afterDelay: 0.1)
        
        score = 0
        createButton()
        createButton()
        createButton()
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
        let button = UIButton()
        buttons.append(button)
        let position = generatePosition()
        
        button.frame = CGRect(x: position.x, y: position.y, width: kButtonSize.width, height: kButtonSize.height)
        button.backgroundColor = UIColor.randomColor
        button.setTitle(Int.random(in: 0...1) == 0 ? "X" : "O", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        gameView.addSubview(button)
    }
    
    func generatePosition() -> CGPoint
    {
        if buttons.count <= 0
        {
            fatalError("Nothing in buttons array shouldnt happen")
        }
        
        var point: CGPoint
        
        // to prevent the buttons placed offscreen, and have + 2 for padding.
        let minX = kButtonSize.width + 2
        let minY = kButtonSize.height + 2
        
        let maxX = gameView.bounds.width - minX
        let maxY = gameView.bounds.height - minY
        
        var canPlace = true
        
        repeat
        {
            canPlace = true
            let x = CGFloat.random(in: minX...maxX)
            let y = CGFloat.random(in: minY...maxY)
            
            point = CGPoint(x: x, y: y)
            
            for button in buttons
            {
                if point.distance(distanceTo: button.center) < (kButtonSize.width + 10)
                {
                    canPlace = false
                }
            }
        }
        while canPlace == false
        
        return point
    }
    
    @objc func buttonPressed(sender: UIButton!)
    {
        score += 100
        sender.isEnabled = false
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                animations:
            {
                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                   relativeDuration: 0.25,
                                   animations:
                    {
                        sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        
                        //sender.transform.scaledBy(x: 1.2, y: 1.2)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.25,
                                   relativeDuration: 0.25,
                                   animations:
                    {
                        sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                     //   sender.transform.scaledBy(x: 0, y: 0)
                })
        }
            , completion: { _ in
                
                if let index = self.buttons.firstIndex(of: sender)
                {
                    self.buttons.remove(at: index)
                    sender.removeFromSuperview()
                    self.createButton()
                }
        })
        
    }
    
    
}
