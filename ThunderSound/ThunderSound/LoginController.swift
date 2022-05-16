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
        //print("tapRegister working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Register1id") as! RegisterController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func loginBT(_ sender: Any)
    {
        //print("tapLogin working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Inicioid") as! InicioController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Olvidar la contraseña
        let tapOlvidar = UITapGestureRecognizer(target: self, action: #selector(self.tapRemember))
        rememberLB.isUserInteractionEnabled = true
        rememberLB.addGestureRecognizer(tapOlvidar)
    }

    @objc
    func tapRemember()
    {
        //print("tapRemember working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RememberPassid") as! RememberController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

//    let Url = String(format: "http://127.0.0.1:8001/api/auth/login")
//        guard let serviceUrl = URL(string: Url) else { return }
//        let parameters: [String: Any] = [
//            "request": [
//                    "xusercode" : "YOUR USERCODE HERE",
//                    "xpassword": "YOUR PASSWORD HERE"
//            ]
//        ]
//        var request = URLRequest(url: serviceUrl)
//        request.httpMethod = "POST"
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        guard let httpBody =
//        try? JSONSerialization.data(withJSONObject: parameters, options: [])
//        else
//        {
//            return
//        }
//        request.httpBody = httpBody
//        request.timeoutInterval = 20
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response
//            {
//                print(response)
//            }
//            if let data = data
//            {
//                do
//                {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                } catch
//                {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
}
