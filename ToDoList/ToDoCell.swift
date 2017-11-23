//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Rob Dekker on 22-11-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    var delegate: ToDoCellDelegate?

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var playerNameLabel: UILabel!

    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    func checkmarkTapped(sender: ToDoCell) {

    }
    
}
