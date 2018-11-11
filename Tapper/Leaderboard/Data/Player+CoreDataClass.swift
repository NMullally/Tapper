//
//  Player+CoreDataClass.swift
//  Tapper
//
//  Created by Niall Mullally on 07/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func createNewPlayer()
    {
        self.name = RandomNameGenerator.shared.getRandomName()
        self.score = Int32.random(in: 0...10000)
    }

    func configureCell(_ cell: PlayerInfoCell)
    {
        cell.mHighScore.text = String(self.score)
        cell.mName.text = self.name
    }
    
    static func fetchPlayers(context: NSManagedObjectContext) -> [Player]
    {
        let fetchRequest:NSFetchRequest<Player> = Player.fetchRequest()
        
        var players:[Player] = []
        
        let scoreSort = NSSortDescriptor(key:"score", ascending:false)
        
        fetchRequest.sortDescriptors = [scoreSort]
        do
        {
            players = try context.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return players
    }
    
}
