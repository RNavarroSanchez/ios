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
        if userTF.text != "" || passwordTF.text != ""
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

        if let user = preferences.string(forKey: "userTF") //aqui va esto o el nick??
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
                view.addGestureRecognizer(tapGesture)
    }
    @objc func tapGestureHandler()
    {
        userTF.endEditing(true)
        passwordTF.endEditing(true)
    }

    @objc
    func tapRemember()//OLVIDAR CONTRASEÑA
    {
        //print("tapRemember working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RememberPassid") as! RememberController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func peticionLogin(userTF: String, passwordTF: String)//Peticion Inicio de Sesión
    {
        let Url = String(format: "http://127.0.0.1:8889/api/auth/login")//cambiar el puerto para pruebas
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
                        if self.myResponse["code"] as! Int != 200
                        {
                            let alert = UIAlertController(title: "Error", message: myResponse["message"] as? String, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                            alert.addAction(action)
                            present(alert, animated: true)
                            
                        }
//                        if self.myResponse["code"] as! Int == 404
//                        {
//                            let alert = UIAlertController(title: "Error", message: myResponse["message"] as? String, preferredStyle: .alert)
//                            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
//                            alert.addAction(action)
//                            present(alert, animated: true)
//                        }
//                        if self.myResponse["code"] as! Int == 400
//                        {
//                            let errores = myResponse["errors"] as! [String: Any]
//                            if let email = errores["email"] as? [String]
//                            {
//                                let alert = UIAlertController(title: "Error", message: email[0], preferredStyle: .alert)
//                                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
//                                alert.addAction(action)
//                                present(alert, animated: true)
//                            }
//                            if let password = errores["password"] as? [String]
//                            {
//                                let alert = UIAlertController(title: "Error", message: password[0], preferredStyle: .alert)
//                                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
//                                alert.addAction(action)
//                                present(alert, animated: true)
//                            }
//                        }
                        if self.myResponse["code"] as! Int == 200
                        {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "Inicioid") as! InicioController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            
                            let shared = UserDefaults.standard
                            shared.setValue(userTF, forKey: "userTF")
                            shared.setValue(passwordTF, forKey: "passwordTF")
                            let datos: [String: Any] = myResponse["data"] as! [String: Any]
                            shared.setValue(datos["token"] as! String, forKey: "token")
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
