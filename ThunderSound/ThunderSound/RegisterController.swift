//
//  RegisterController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class RegisterController: UIViewController
{
    
    @IBOutlet var emailTFr: UITextField!
    @IBOutlet var passTFr: UITextField!
    @IBOutlet var passx2TFr: UITextField!
    
    @IBAction func continueBTr(_ sender: Any)
    {
        //print("tapContinue working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Register2id") as! Register2Controller
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
