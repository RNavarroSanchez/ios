//
//  TableViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class TableViewCell: UITableViewCell
{
    @IBOutlet var comentarioIV: UIImageView!
    @IBOutlet var userNameComentLB: UILabel!
    @IBOutlet var comentarioNewTF: UITextField!
    @IBOutlet var dateNewComentLB: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        
    }

}
