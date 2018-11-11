//
//  Collection+index.swift
//  Tapper
//
//  Created by Niall Mullally on 11/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation

extension Collection
{
    // inserting item into array and getting the correct index it should be placed into array
    func insertionIndex(of element: Self.Iterator.Element,
            using areInIncreasingOrder: (Self.Iterator.Element, Self.Iterator.Element) -> Bool) -> Index
    {
        // if we cant find a place to insert it, it gets put at the back
        return index(where: { !areInIncreasingOrder($0, element) }) ?? endIndex
    }
}
