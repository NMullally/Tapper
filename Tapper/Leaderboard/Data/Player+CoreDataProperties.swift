//
//  Player+CoreDataProperties.swift
//  Tapper
//
//  Created by Niall Mullally on 07/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Int32

}
