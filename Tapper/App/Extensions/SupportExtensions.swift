//
//  SupportExtensions.swift
//  Tapper
//
//  Created by Niall Mullally on 12/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor
{
    static var randomColor: UIColor
    {
        return UIColor(displayP3Red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: 1.0)
    }
}

public extension CGPoint
{
    public func distance(distanceTo: CGPoint) -> CGFloat
    {
        return sqrt(pow(distanceTo.x - x , 2) + pow(distanceTo.y - y, 2))
    }
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint
{
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
