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
    @IBAction func registerBT(_ sender: Any)//Registro
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Registerid") as! RegisterController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func loginBT(_ sender: Any)//Inicio de Sesión
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
        var preferences = UserDefaults.standard

        if let user = preferences.string(forKey: "userTF")
        {
            if let pass = preferences.string(forKey: "passwordTF")
            {
                if user != "" && pass != ""
                {
                    peticionLogin(userTF: user, passwordTF: pass)
                }
            }
        }
        //tapOlvidar la contraseña
        let tapOlvidar = UITapGestureRecognizer(target: self, action: #selector(self.tapRemember))
        rememberLB.isUserInteractionEnabled = true
        rememberLB.addGestureRecognizer(tapOlvidar)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func tapRemember()//OLVIDAR CONTRASEÑA
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RememberPassid") as! RememberController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func peticionLogin(userTF: String, passwordTF: String)//Peticion Inicio de Sesión
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
            if let response = response
            {
                print(response)
            }
            if let data = data
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    DispatchQueue.main.async
                    { [self] in
                        print(json)
                        
                        self.myResponse = json as! [String: Any]
                        if self.myResponse["error"] as? String == "Unauthorized"
                        {
//                            print(self.myResponse["statusCode"])
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
                        }
                        //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8zNS4xODEuMTYwLjEzOFwvcHJveWVjdG9zXC90aHVuZGVyMjJcL3B1YmxpY1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY1MzQ5NDA1MywiZXhwIjoxNjUzNDk3NjUzLCJuYmYiOjE2NTM0OTQwNTMsImp0aSI6Im5XNWZKUG40ckFUdEFyRzgiLCJzdWIiOjUxLCJwcnYiOiIwYjBjZjUwYWYxMjNkODUwNmUxNmViYTdjYjY3NjI5NzRkYTNhYzNhIn0.icrjZxxHaji2AQEpNaSkWcmpwFj47DolrppHcBN_BgM
                    }
                } catch
                {
                    print(error)
                }
            }
        }.resume()
    }
}
