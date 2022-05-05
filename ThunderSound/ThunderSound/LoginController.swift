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

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        rememberLB.isUserInteractionEnabled = true
        rememberLB.addGestureRecognizer(tap)
    }

    @objc
    func tapFunction()
    {
        print("tap working")
        //he puesto storyboard id RememberPass
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "secondStoryboardId") as! SecondViewController
//           self.present(nextViewController, animated:true, completion:nil)
    }
}
