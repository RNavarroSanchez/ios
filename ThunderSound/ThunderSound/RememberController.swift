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
        if emailRememberTF.text != nil
        {
            peticionRemember(emailRememberTF: emailRememberTF.text!)
        } else
        {
            let alert = UIAlertController(title: "Error", message: "No puedes dejar el campo sin rellenar", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func atrasBT(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    var myResponse: [String: Any] = [:]
    func peticionRemember(emailRememberTF: String)
    {
        let Url = String(format: "http://35.181.160.138/proyectos/thunder22/public/api/email")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "correo=\(emailRememberTF)"
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
                        self.myResponse = json as! [String: Any]
                        if self.myResponse["error"] as? String != nil
                        {
                            let alert = UIAlertController(title: "Error", message: myResponse["message"] as? String, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                            alert.addAction(action)
                            present(alert, animated: true)
                        } else
                        {
                            let alert = UIAlertController(title: "Correo enviado", message: "Correo con la recuperacion de contraseña enviado, gracias por confiar en nosotros.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                            alert.addAction(action)
                            present(alert, animated: true)
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
