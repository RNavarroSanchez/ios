//
//  NotifTableViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class NotifTableViewCell: UITableViewCell
{
    @IBOutlet var textoNotifTV: UILabel!
    @IBOutlet var iconNotifIMG: UIImageView!
    @IBOutlet var userNotifIMG: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    

}
