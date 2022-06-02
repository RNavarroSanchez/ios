//
//  AlertController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit
import WebKit

class AlertController: UIViewController
{
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var nameUserLB: UILabel!
    @IBOutlet var alertView: UIView!
    @IBOutlet var publicarBT: UIButton!
    @IBOutlet var comentarioTF: UITextField!
    @IBOutlet var spotifyWebView: WKWebView!
    @IBAction func cerrarNewPostBT(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "FondoThunderSound.png")!)
        // Redondear IMG
        self.imgUser.layer.cornerRadius = 20
        self.imgUser.clipsToBounds = true
        // Redondear View
        self.alertView.layer.cornerRadius = 22
        self.alertView.clipsToBounds = true
        // Redondear TextField
        self.comentarioTF.layer.cornerRadius = 15
        self.comentarioTF.clipsToBounds = true
        // Redondear BT
        self.publicarBT.layer.cornerRadius = 8
        self.publicarBT.clipsToBounds = true
        
        spotifyWebView.loadHTMLString("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Document</title></head><body><iframe style=\"border-radius:12px\" src=\"https://open.spotify.com/embed/track/1b62AO1IzcVr5SOgoguc9o?utm_source=generator\" width=\"100%\" height=\"90%\" frameBorder=\"0\" allowfullscreen=\"\" allow=\"autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture\"></iframe></body></html>"
                                       , baseURL: nil)
        //HACER DINAMICA \()
    }
}
