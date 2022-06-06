//
//  LoginController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class LoginController: UIViewController
{
    var myResponse: [String: Any] = [:]
    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var rememberLB: UILabel!
    @IBAction func registerBT(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Registerid") as! RegisterController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func loginBT(_ sender: Any)
    {
        if userTF.text != nil || passwordTF.text != nil
        {
            peticionLogin(userTF: userTF.text!, passwordTF: passwordTF.text!)
        } else
        {
            let alert = UIAlertController(title: "Error", message: "No puedes dejar un campo sin rellenar", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let shared = UserDefaults.standard
        shared.setValue("", forKey: "userTF")
        shared.setValue("", forKey: "passwordTF")
        shared.setValue("", forKey: "token")
        if let user = shared.string(forKey: "userTF")
        {
            if let pass = shared.string(forKey: "passwordTF")
            {
                if user != "" && pass != ""
                {
                    peticionLogin(userTF: user, passwordTF: pass)
                }
            }
        }

        let tapOlvidar = UITapGestureRecognizer(target: self, action: #selector(self.tapRemember))
        rememberLB.isUserInteractionEnabled = true
        rememberLB.addGestureRecognizer(tapOlvidar)
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func tapRemember()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RememberPassid") as! RememberController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func peticionLogin(userTF: String, passwordTF: String)
    {
        let Url = String(format: "http://35.181.160.138/proyectos/thunder22/public/api/auth/login")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "nick=\(userTF)&password=\(passwordTF)"
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{print(response)}
            if let data = data
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async
                    { [self] in
                        self.myResponse = json as! [String: Any]
                        print(json)
                        if self.myResponse["error"] as? String == "Unauthorized"
                        {
                            let alert = UIAlertController(title: "Error", message: myResponse["message"] as? String, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                            alert.addAction(action)
                            present(alert, animated: true)
                        }
                        if self.myResponse["access_token"] != nil
                        {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "Inicioid") as! InicioController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            let shared = UserDefaults.standard
                            shared.setValue(userTF, forKey: "userTF")
                            shared.setValue(passwordTF, forKey: "passwordTF")
                            shared.setValue(myResponse["access_token"] as! String, forKey: "token")
                            let id = self.myResponse["id"]
                            shared.setValue(id, forKey: "id")
                        }
                    }
                } catch
                {
                    print(error)
                }
            }
        }.resume()
    }
}
