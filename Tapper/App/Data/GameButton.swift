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
    
    button should use rounded rect that goes from square to almost circle and then scale in if possible when deleting.
    
    let kButtonSize = CGSize(width: 50, height: 50)
    let (minDuration, maxDuration) = (2.0, 5.0)
    let kButtonCorrectScore = 100
    let kButtonWrongScore = -100
    
    private weak var gameView: UIView? = GameManager.shared.gameView
    
    private var wasPressed: Bool = false
    
    var destroyTimer: Timer? = nil

    // try rename , cant use button type and unsure of other name
    enum ButtonSafety
    {
        case Safe, Unsafe
    }
    
    var position: CGPoint = CGPoint.zero
    var isSafe: ButtonSafety = .Safe
    
    @objc func setupTimers()
    {
        return;
            
        destroyTimer = Timer.scheduledTimer(timeInterval: TimeInterval.random(in: minDuration...maxDuration),
                                            target: self,
                                            selector: #selector(removeButtonAnimation),
                                            userInfo: nil,
                                            repeats: false)
    }
    
    func setupButton()
    {
        setupTimers()
        isSafe = Int.random(in: 0...1) == 0 ? .Safe : .Unsafe
        
        let position = generatePosition()
        
        self.isEnabled = false
        self.frame = CGRect(x: position.x, y: position.y, width: kButtonSize.width, height: kButtonSize.height)
        self.backgroundColor = UIColor.randomColor
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.setTitle(isSafe == .Safe ? "X" : "O", for: .normal)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                animations:
            {
                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                   relativeDuration: 0.5,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.5,
                                   relativeDuration: 0.3,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
        }
            , completion: { _ in
                self.isEnabled = true
                
                self.performSelector(onMainThread: #selector(self.setupTimers), with: nil, waitUntilDone: false)
        })
    }
    
    func generatePosition() -> CGPoint
    {
        var point: CGPoint
        
        // to prevent the buttons placed offscreen, and have + 2 for padding.
        let minX = kButtonSize.width + 2
        let minY = kButtonSize.height + 2
        
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
                if dist < (kButtonSize.width + 10)
                {
                    canPlace = false
                    break
                }
            }
        } while canPlace == false
        
        // return the center point of the button
        return point - CGPoint(x: kButtonSize.width / 2, y: kButtonSize.height / 2)
    }
    
    @objc func buttonPressed(sender: UIButton!)
    {
        wasPressed = true

        GameManager.shared.incrementScore(amount: self.isSafe == ButtonSafety.Safe ? kButtonCorrectScore : kButtonWrongScore)
        
        destroyTimer?.invalidate()
        
        removeButtonAnimation()
    }
    
    @objc func removeButtonAnimation()
    {
        self.isEnabled = false

        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                animations:
            {
                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                   relativeDuration: 0.25,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.25,
                                   relativeDuration: 0.25,
                                   animations:
                    {
                        self.transform = CGAffineTransform(scaleX: 0, y: 0)
                })
        }
            , completion: { _ in
                ButtonManager.shared.removeButton(button: self)
        })
    }
}
