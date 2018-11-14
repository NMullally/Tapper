//
//  ButtonManager.swift
//  Tapper
//
//  Created by Niall Mullally on 12/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation
import UIKit

class ButtonManager
{
    static let shared = ButtonManager()
    weak var gameView: UIView!
    
    var buttons: [GameButton] = []
    
    enum ButtonType {
        case Button, Slider, Switch
    }
    
    private init()
    {
    }
    
    func addButton()
    {
        let newButton = GameButton()
        newButton.setupButton()
        
        buttons.append(newButton)
        gameView.addSubview(newButton)
        
    }
    
    // should reuse rather than create and delete
    func removeButton(button: GameButton)
    {
        if let index = buttons.firstIndex(of: button)
        {
            self.buttons.remove(at: index)
            button.removeFromSuperview()
            addButton()
        }
    }
    
}
