//
//  TableViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class TableViewCell: UITableViewCell
{
    
    @IBOutlet var comentarioIMG: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
