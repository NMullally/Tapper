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
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var comboLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer: Int = 0
    {
        didSet
        {
            
        }
    }
    
    var combo: Int = 0
    {
        didSet
        {
            
        }
    }
    
    var level: Int = 0
    {
        didSet
        {
            
        }
    }
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}


extension ViewController
{
    
}

