//
//  Register2Controller.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class Register2Controller: UIViewController
{
    @IBOutlet var editarIMG: UIImageView!
    @IBOutlet var descripcionTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "FondoThunderSound.png")!)
        
        // Redondear IMG
        self.editarIMG.layer.cornerRadius = 55
        self.editarIMG.clipsToBounds = true
        
        // Redondear TextField
        self.descripcionTF.layer.cornerRadius = 10
        self.descripcionTF.clipsToBounds = true
        
    }
}
