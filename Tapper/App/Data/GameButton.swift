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
    let kButtonSize = CGSize(width: 50, height: 50)
    
    lazy var gameView: UIView? = ButtonManager.shared.gameView
    static var delegate: scoreDelegate?

    // try rename , cant use button type and unsure of other name
    enum ButtonSafety
    {
        case Safe, Unsafe
    }
    var position: CGPoint = CGPoint.zero
    var isSafe: ButtonSafety = .Safe
    
    func setupButton()
    {
        let position = generatePosition() - CGPoint(x: kButtonSize.width / 2, y: kButtonSize.height / 2)
        
        self.frame = CGRect(x: position.x, y: position.y, width: kButtonSize.width, height: kButtonSize.height)
        self.backgroundColor = UIColor.randomColor
        self.setTitle(Int.random(in: 0...1) == 0 ? "X" : "O", for: .normal)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.isEnabled = false
        
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
                    print("\(dist)")
                    canPlace = false
                    break
                }
            }
        }
            while canPlace == false
        
        return point
    }
    
    @objc func buttonPressed(sender: UIButton!)
    {
        GameButton.delegate?.incrementScore()
        
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
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.25,
                                   relativeDuration: 0.25,
                                   animations:
                    {
                        sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                })
        }
            , completion: { _ in
                
                ButtonManager.shared.removeButton(button: sender as! GameButton)
        })
    }
}
