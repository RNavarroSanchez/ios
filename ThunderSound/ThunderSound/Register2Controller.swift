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
    @IBOutlet var userTFr2: UITextField!
    @IBOutlet var nameTFr2: UITextField!
    @IBOutlet var subnameTFr2: UITextField!
    @IBOutlet var descripcionTFr2: UITextField!
    
    @IBAction func registerBTr2(_ sender: Any)
    {
        //print("tapRegister2 working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Inicioid") as! InicioController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Redondear IMG
        self.editarIMG.layer.cornerRadius = 55
        self.editarIMG.clipsToBounds = true
        
        // Redondear TextField
        self.descripcionTFr2.layer.cornerRadius = 10
        self.descripcionTFr2.clipsToBounds = true
        
    }
}
