//
//  MainMenuViewController.swift
//  Tapper
//
//  Created by Niall Mullally on 04/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

public protocol MainMenuViewControllerDelegate: class
{
    func mainMenuControllerStartPressed(_ controller: MainMenuViewController)
}

public class MainMenuViewController: UIViewController {

    public var delegate: MainMenuViewControllerDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startGamePressed()
    {
        delegate?.mainMenuControllerStartPressed(self)
    }
    
}
