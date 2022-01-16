//
//  TodoCell.swift
//  To Do List project
//
//  Created by MARAM on 23/04/1443 AH.
//

import UIKit

class TodoCell: UITableViewCell {

      
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todeCreationDateLabel: UILabel!
    @IBOutlet weak var todosImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
