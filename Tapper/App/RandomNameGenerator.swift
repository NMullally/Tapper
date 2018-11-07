//
//  RandomNameGenerator.swift
//  Tapper
//
//  Created by Niall Mullally on 07/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation

class RandomNameGenerator
{
    static let shared = RandomNameGenerator()
    lazy var namesArray: [String] = []
    
    
    private init()
    {
        do
        {
            try loadNamesJSON()
        }
        catch
        {
            print("Error retrieving json from resources")
        }
    }
    
    private func loadNamesJSON() throws
    {
        do
        {
            let firstNamePath = Bundle.main.path(forResource: "first-names", ofType: "json")!
            let firstNameUrl = URL(fileURLWithPath: firstNamePath)
            
            let jsonData = try Data(contentsOf: firstNameUrl)
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String]
            
            for name in jsonArray
            {
                namesArray.append(name)
            }
        }
    }
    
    func getRandomName() -> String
    {
        if namesArray.isEmpty
        {
            do
            {
                try loadNamesJSON()
            }
            catch
            {
                print("Error retrieving json from resources")
                return ""
            }
        }
       
        return namesArray.randomElement()!
    }
}
