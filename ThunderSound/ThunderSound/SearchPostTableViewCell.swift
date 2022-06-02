//
//  SearchPostTableViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit
import WebKit

class SearchPostTableViewCell: UITableViewCell
{
    @IBOutlet var spotifyWebView: WKWebView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
