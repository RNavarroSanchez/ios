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
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedLabel(tapGestureRecognizer:)))
//        rememberLB.isUserInteractionEnabled = true
//        rememberLB.addGestureRecognizer(tapGesture)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        rememberLB.isUserInteractionEnabled = true
        rememberLB.addGestureRecognizer(tap)
    }

    @objc
    func tapFunction()
    {
        print("tap working")
    }
    
//    @objc func tappedLabel(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        print("tap working")
//    }
}
