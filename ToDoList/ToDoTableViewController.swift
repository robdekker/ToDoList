//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Rob Dekker on 22-11-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    var players = [Player]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else { fatalError("Could not dequeue a cell") }
        
        cell.delegate = self

        let player = players[indexPath.row]
        cell.playerNameLabel?.text = player.playerName
        cell.isCompleteButton.isSelected = player.isComplete
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Player.savePlayers(players)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedPlayer = players[indexPath.row]
            todoViewController.player = selectedPlayer
        }
    }
    
    @IBAction func unwindToPlayerList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! ToDoViewController
        
        if let player = sourceViewController.player {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                players[selectedIndexPath.row] = player
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: players.count, section: 0)
                players.append(player)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Player.savePlayers(players)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedPlayers = Player.loadPlayers() {
            players = savedPlayers
        } else {
            players = Player.loadSamplePlayers()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var player = players[indexPath.row]
            player.isComplete = !player.isComplete
            players[indexPath.row] = player
            tableView.reloadRows(at: [indexPath], with: .automatic)
            Player.savePlayers(players)
        }
    }
}
