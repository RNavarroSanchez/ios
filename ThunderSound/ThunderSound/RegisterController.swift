//
//  RegisterController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class RegisterController: UIViewController
{
    
    @IBAction func atrasBT(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBOutlet var emailTFr: UITextField!
    @IBOutlet var passTFr: UITextField!
    @IBOutlet var passx2TFr: UITextField!
    
    @IBOutlet var editarIMG: UIImageView!
    @IBOutlet var userTFr: UITextField!
    @IBOutlet var nameTFr: UITextField!
    @IBOutlet var subnameTFr: UITextField!
    @IBOutlet var descripcionTFr: UITextField!
    
    @IBAction func registerBTr(_ sender: Any)
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
        self.descripcionTFr.layer.cornerRadius = 10
        self.descripcionTFr.clipsToBounds = true
    }
}
