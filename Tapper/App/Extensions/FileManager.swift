//
//  File.swift
//  Tapper
//
//  Created by Niall Mullally on 07/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation

// small extension to get the document directory url
public extension FileManager
{
    static var documentDirectoryURL: URL
    {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
