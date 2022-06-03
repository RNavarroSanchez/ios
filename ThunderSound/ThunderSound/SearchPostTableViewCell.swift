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

//
//1 - track(Diccionario)
//2 - track["items"] (Array con las canciones)
//3 - items[0] (Diccionario con una canción)
//4- cancion["id] y cancion["name]
