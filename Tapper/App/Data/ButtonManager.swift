//
//  ButtonManager.swift
//  Tapper
//
//  Created by Niall Mullally on 12/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation
import UIKit

// try rename , cant use button type and unsure of other name
enum ButtonSafety {
    case Safe, Unsafe
}

struct GameButton
{
    var button: UIButton
    var position: CGPoint
    var isSafe: ButtonSafety
    
    init() {
        button = UIButton()
        button.backgroundColor = UIColor.randomColor
        
        isSafe = Int.random(in: 0...1) == 0 ? ButtonSafety.Safe : ButtonSafety.Unsafe
        position = CGPoint.zero
    }
}


class ButtonManager
{
    static let shared = ButtonManager()
    
    enum ButtonType {
        case Button, Slider, Switch
    }
    
    private init()
    {
    }
    
    func createRandomArray(for level: Int) -> [ButtonType]
    {
        var returnArray: [ButtonType] = []
        
        returnArray.append(contentsOf: [ButtonType.Button, .Button, .Button, .Button])
        
        if level > 4
        {
            
        }
        
        return returnArray
    }
    
    func setupButtons(buttons: [ButtonType])
    {
        var array = [GameButton(), GameButton(), GameButton()]
        
        for button in array
        {
            button.button.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
            
        }
    }
    
    
}
