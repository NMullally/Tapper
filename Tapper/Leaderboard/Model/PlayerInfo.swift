//
//  PlayerInfo.swift
//  Tapper
//
//  Created by Niall Mullally on 06/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation

class PlayerInfo: NSObject
{
    var score: Int = 0
    var name: String = "Empty"
 
    init(name: String, score: Int)
    {
        self.name = name
        self.score = score
    }
    
    override init() {
        self.name = RandomNameGenerator.shared.getRandomName()
        self.score = Int.random(in: 0...10000)
    }
    
    func configureCell(_ cell: PlayerInfoCell)
    {
        cell.mHighScore.text = String(self.score)
        cell.mName.text = self.name
    }
}
