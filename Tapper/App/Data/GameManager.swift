//
//  GameManager.swift
//  Tapper
//
//  Created by Niall Mullally on 14/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

// Notes for self

/*
 *  Progress bar will be fixed for each level
        When it hits 0 , the buttons will despawn, starting a new level
        If user hits all the correct buttons before it hits 0 then the bonus increases
        Bonus hits 0 when the user fails to clear all the correct buttons
 *
 *
 *
 *
 *
 */

import Foundation
import UIKit

class GameManager
{
    
    enum GameDetails
    {
        static let MaxButtons = 5
        static let StartTimer = 3
    }
    
    static let shared = GameManager()
    
    var scoreDelegate: scoreDelegate?
    
    weak var gameView: UIView!
        
    private init()
    {
        // init other managers
    }
    
    func incrementScore(amount: Int)
    {
        scoreDelegate?.incrementScore(amount: amount)
    }
    
    func spawnButtons()
    {
        for _ in 0...GameDetails.MaxButtons
        {
            ButtonManager.shared.addButton()
        }
    }
    
    func clearButtons()
    {
        ButtonManager.shared.clearButtons()
    }
}
