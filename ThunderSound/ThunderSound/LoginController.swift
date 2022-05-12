//
//  LoginController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class LoginController: UIViewController
{
    
    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var rememberLB: UILabel!
    
    @IBAction func registerBT(_ sender: Any)
    {
        
    }
    @IBAction func loginBT(_ sender: Any)
    {
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapRemember))
        rememberLB.isUserInteractionEnabled = true
        rememberLB.addGestureRecognizer(tap)
    }

    @objc
    func tapRemember()
    {
        print("tapRemember working")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RememberPassid") as! RememberController
        self.present(vc, animated: true, completion: nil)
    }
}
