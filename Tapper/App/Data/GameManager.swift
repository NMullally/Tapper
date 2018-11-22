//
//  GameManager.swift
//  Tapper
//
//  Created by Niall Mullally on 14/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation
import UIKit

class GameManager
{
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
    
    
}
