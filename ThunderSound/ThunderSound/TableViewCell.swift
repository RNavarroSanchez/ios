//
//  TableViewCell.swift
//  ThunderSound
//
//  Created by A1-IMAC08 on 27/4/22.
//

import UIKit

class TableViewCell: UITableViewCell
{
    
    @IBOutlet var comentarioIMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
