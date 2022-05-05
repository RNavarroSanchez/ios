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
    @IBOutlet var cerrarNewPostBT: UIButton!
    @IBOutlet var nameUserLB: UILabel!
    @IBOutlet var alertView: UIView!
    @IBOutlet var publicarBT: UIButton!
    @IBOutlet var comentarioTF: UITextField!
    @IBOutlet var spotifyWebView: WKWebView!
    
    
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
        
        // Redondear View
        self.comentarioTF.layer.cornerRadius = 15
        self.comentarioTF.clipsToBounds = true
        
        // Redondear BT
        self.publicarBT.layer.cornerRadius = 8
        self.publicarBT.clipsToBounds = true
    }
}
