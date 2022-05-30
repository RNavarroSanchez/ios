//
//  SearchTableViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class SearchTableViewCell: UITableViewCell
{
    @IBOutlet var nameLB: UILabel!
    @IBOutlet var nickLB: UILabel!
    @IBOutlet var perfilIMG: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
