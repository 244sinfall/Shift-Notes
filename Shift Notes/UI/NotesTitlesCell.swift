//
//  NotesTitlesCell.swift
//  Shift Notes
//
//  Created by Дмитрий Филин on 31.01.2022.
//

import UIKit

class NotesTitlesCell: UITableViewCell {

    @IBOutlet weak var noteTitleLabel: UILabel!

    @IBOutlet weak var noteDateCreatedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
