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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedLabel(tapGestureRecognizer:)))
        rememberLB.addGestureRecognizer(tapGesture)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginController.tapFunction))
//        rememberLB.isUserInteractionEnabled = true
//        rememberLB.addGestureRecognizer(tap)
    }
    
//    @objc
//    func tapFunction(sender:UITapGestureRecognizer)
//    {
//        print("tap working")
//    }
    
    @objc func tappedLabel(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("tap working")
    }
}
