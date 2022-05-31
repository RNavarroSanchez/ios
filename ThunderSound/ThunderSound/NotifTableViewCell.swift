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
        
        self.iconNotifIMG.layer.cornerRadius = 40 //Comprobar si quedan bien estos valores
        self.iconNotifIMG.clipsToBounds = true
        self.userNotifIMG.layer.cornerRadius = 40
        self.userNotifIMG.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
