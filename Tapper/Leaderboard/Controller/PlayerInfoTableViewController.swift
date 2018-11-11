//
//  PlayerInfoTableViewController.swift
//  Tapper
//
//  Created by Niall Mullally on 06/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class PlayerInfoTableViewController: UITableViewController
{
    var tableData: [Player] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let addItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.navigationItem.rightBarButtonItems = [editButtonItem, addItemButton]
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do
        {
            tableData = try context.fetch(Player.fetchRequest())
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool)
    {
        // we just hit the done button
        // has to be called before super otherwise the selected items array is cleared
        if editing == false
        {
            deleteItem(nil)
        }
        super.setEditing(editing, animated: animated)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    @objc func addItem()
    {
        let player = Player(entity: Player.entity(), insertInto: context)
        player.createNewPlayer()
        tableData.append(player)
        
        appDelegate.saveContext()
        
        // rather than reloading all the tableview data, we just call insert at the index of hte new item
        let row = tableData.count - 1
        let indexPath = IndexPath(row: row, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @IBAction func deleteItem(_ sender: Any?)
    {
        if let selectedRows = tableView.indexPathsForSelectedRows
        {
            for indexPath in selectedRows
            {
                let row = indexPath.row > tableData.count - 1  ? tableData.count - 1 : indexPath.row
//                let player = tableData[row]
                let player = tableData.remove(at: row)
                context.delete(player)
                appDelegate.saveContext()
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerInfoCell", for: indexPath) as! PlayerInfoCell

        let playerInfo = tableData[indexPath.row]
        playerInfo.configureCell(cell)
        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
