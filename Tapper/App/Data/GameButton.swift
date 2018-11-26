//
//  GameButton.swift
//  Tapper
//
//  Created by Niall Mullally on 14/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class GameButton: UIButton
{
    
    //    button should use rounded rect that goes from square to almost circle and then scale in if possible when deleting.
    
    // try rename , cant use button type and unsure of other name
    enum ButtonSafety
    {
        case Safe, Unsafe
    }
    
    private enum Score
    {
        static let Incorrect = -100
        static let Correct = 100
    }
    
    private enum kButton
    {
        static let Width : CGFloat = 50
        static let Height : CGFloat = 50
        static let Padding : CGFloat = 2
        static let BorderWidth : CGFloat = 5
        static let BorderColor : CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let DistanceBetween = {return kButton.Width + 10}
    }
    
    private enum Constants
    {
        static let minDuration = 2.0
        static let maxDuration = 5.0
    }
    
    private enum kDisplayAnimation
    {
        static let TotalDuration = 0.8
        static let InitalScaleDuration = 0.5
        static let ScaleTo : CGFloat = 1.2
        static let FinalScaleDuration = 0.3
        static let FinalScale : CGFloat = 1.0
    }
    
    private enum kRemoveAnimation
    {
        static let TotalDuration = 0.5
        static let InitalScaleDuration = 0.25
        static let ScaleTo : CGFloat = 1.2
        static let FinalScaleDuration = 0.25
        static let FinalScale : CGFloat = 0.0
        
        static let cornerRadius = { return kButton.Width / 2 }
    }
    
    private weak var gameView: UIView? = GameManager.shared.gameView
    
    private var wasPressed: Bool = false
    var destroyTimer: Timer? = nil
    var position: CGPoint = CGPoint.zero
    var isSafe: ButtonSafety = .Safe
    
    @objc func setupTimers()
    {
        return;
        
        destroyTimer = Timer.scheduledTimer(timeInterval: TimeInterval.random(in: Constants.minDuration...Constants.maxDuration),
                                            target: self,
                                            selector: #selector(removeButtonAnimation),
                                            userInfo: nil,
                                            repeats: false)
    }
    
    func setupButton()
    {
        //    self.layer.cornerRadius = 25
        self.layer.borderWidth = kButton.BorderWidth
        self.layer.borderColor = kButton.BorderColor
        
        setupTimers()
        isSafe = Int.random(in: 0...1) == 0 ? .Safe : .Unsafe
        
        let position = generatePosition()
        
        self.isEnabled = false
        self.frame = CGRect(x: position.x, y: position.y, width: kButton.Width, height: kButton.Height)
        self.backgroundColor = UIColor.randomColor
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.setTitle(isSafe == .Safe ? "X" : "O", for: .normal)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        displayButtonAnimation()
    }
    
    func generatePosition() -> CGPoint
    {
        var point: CGPoint
        
        // to prevent the buttons placed offscreen, and have + 2 for padding.
        let minX = kButton.Width + kButton.Padding
        let minY = kButton.Height + kButton.Padding
        
        let maxX = gameView!.bounds.width - minX
        let maxY = gameView!.bounds.height - minY
        
        var canPlace = true
        
        repeat
        {
            canPlace = true
            let x = CGFloat.random(in: minX...maxX)
            let y = CGFloat.random(in: minY...maxY)
            
            point = CGPoint(x: x, y: y)
            
            for button in ButtonManager.shared.buttons
            {
                let dist = point.distance(distanceTo: button.center)
                if dist < kButton.DistanceBetween()
                {
                    canPlace = false
                    break
                }
            }
        } while canPlace == false
        
        // return the center point of the button
        return point - CGPoint(x: kButton.Width / 2, y: kButton.Height / 2)
    }
    
    @objc func buttonPressed(sender: UIButton!)
    {
        wasPressed = true
        
        GameManager.shared.incrementScore(amount: self.isSafe == ButtonSafety.Safe ? Score.Correct : Score.Incorrect)
        
        destroyTimer?.invalidate()
        
        removeButtonAnimation()
    }
    
    @objc func removeButtonAnimation()
    {
        self.isEnabled = false
        
        self.layer.borderColor = isSafe == ButtonSafety.Safe ? #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        
        UIView.animateKeyframes(withDuration: kRemoveAnimation.TotalDuration,
                                delay: 0,
                                animations:
            {
                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                   relativeDuration: kRemoveAnimation.InitalScaleDuration,
                                   animations:
                    {
                        if self.wasPressed
                        {
                            self.layer.cornerRadius = kRemoveAnimation.cornerRadius()
                        }
                        
                        self.transform = CGAffineTransform(scaleX: kRemoveAnimation.ScaleTo,
                                                           y: kRemoveAnimation.ScaleTo)
                })
                
                UIView.addKeyframe(withRelativeStartTime: kRemoveAnimation.InitalScaleDuration,
                                   relativeDuration: kRemoveAnimation.FinalScaleDuration,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: kRemoveAnimation.FinalScale,
                                                           y: kRemoveAnimation.FinalScale)
                })
        }
            , completion: { _ in
                ButtonManager.shared.removeButton(button: self)
        })
    }
    
    func displayButtonAnimation()
    {
        UIView.animateKeyframes(withDuration: kDisplayAnimation.TotalDuration,
                                delay: 0,
                                animations:
            {
                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                   relativeDuration: kDisplayAnimation.InitalScaleDuration,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: kDisplayAnimation.ScaleTo,
                                                           y: kDisplayAnimation.ScaleTo)
                })
                
                UIView.addKeyframe(withRelativeStartTime: kDisplayAnimation.InitalScaleDuration,
                                   relativeDuration: kDisplayAnimation.FinalScaleDuration,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: kDisplayAnimation.FinalScale,
                                                           y: kDisplayAnimation.FinalScale)
                })
        }
            , completion: { _ in
                self.isEnabled = true
                
                self.performSelector(onMainThread: #selector(self.setupTimers), with: nil, waitUntilDone: false)
        })
    }
}
