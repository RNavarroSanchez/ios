//
//  PerfilController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class PerfilController: UIViewController
{
    @IBOutlet var userNameLBp: UILabel!
    @IBOutlet var myProfileIVp: UIImageView!
    @IBOutlet var followersLBp: UILabel!
    @IBOutlet var followLBp: UILabel!
    @IBOutlet var postLBp: UILabel!
    @IBOutlet var descriptionLBp: UILabel!
    
    @IBAction func editeBTp(_ sender: Any)
    {
        
    }
    
    @IBAction func logoutBTp(_ sender: Any)
    {
        let shared = UserDefaults.standard
        shared.setValue("", forKey: "userTF")
        shared.setValue("", forKey: "passwordTF")
        shared.setValue("", forKey: "token")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Loginid") as! LoginController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
