//
//  ToDo.swift
//  ToDoList
//
//  Created by Rob Dekker on 22-11-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit

struct Player: Codable {
    var playerName: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players").appendingPathExtension("plist")
    
    static func loadPlayers() -> [Player]? {
        guard let codedPlayers = try? Data(contentsOf: ArchiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Player>.self, from: codedPlayers)
    }
    
    static func savePlayers(_ players: [Player]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedPlayers = try? propertyListEncoder.encode(players)
        try? codedPlayers?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadSamplePlayers() -> [Player] {
        let player1 = Player(playerName: "Isco", isComplete: false, dueDate: Date(),  notes: "Plays for Real Madrid")
        let player2 = Player(playerName: "Casemiro", isComplete: false,  dueDate: Date(), notes: "Plays for Real Madrid")
        let player3 = Player(playerName: "Dembele", isComplete: false,  dueDate: Date(), notes: "Plays for FC Barcelona")
        
        return [player1, player2, player3]
    }
    
}

enum Position {
    case goalkeeper, defender, midfielder, attacker
}
