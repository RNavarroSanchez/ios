//
//  RememberController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class RememberController: UIViewController
{
    @IBOutlet var emailRememberTF: UITextField!
    
    @IBAction func sendEmailBT(_ sender: Any)
    {
        
    }
    
    @IBAction func atrasBT(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

}
