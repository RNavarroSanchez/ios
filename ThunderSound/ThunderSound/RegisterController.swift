//
//  RegisterController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate
{
    
    @IBAction func atrasBT(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBOutlet var emailTFr: UITextField!
    @IBOutlet var passTFr: UITextField!
    @IBOutlet var passx2TFr: UITextField!
    @IBOutlet var editarIMG: UIImageView!
    @IBOutlet var userTFr: UITextField!
    @IBOutlet var nameTFr: UITextField!
    @IBOutlet var subnameTFr: UITextField!
    @IBOutlet var descripcionTFr: UITextField!
    var myDictionary: [String: Any] = [:]
    
    @IBAction func registerBTr(_ sender: Any)
    {
        if emailTFr.text != "" && passTFr.text == passx2TFr.text && userTFr.text != "" && nameTFr.text != "" && subnameTFr.text != ""
        {
            let Url = String(format: "http://127.0.0.1:8889/api/usuarios")
            guard let serviceUrl = URL(string: Url) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let bodyData = "correo=\(emailTFr.text ?? "")&password=\(passTFr.text ?? "")&nick=\(userTFr.text ?? "")&nombre=\(nameTFr.text ?? "")&apellidos=\(subnameTFr.text ?? "")&descripcion=\(descripcionTFr.text ?? "")"
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
                        {
                            self.myDictionary = json as! [String: Any]

                            if self.myDictionary["code"] as! Int == 200
                            {
                                let alert = UIAlertController(title: "LLego el momento...", message: "Registro completado con éxito", preferredStyle: .alert)
                                let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
                                    self.navigationController?.popToRootViewController(animated: true)
                                })
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                
                            } else
                            {
                                let alert = UIAlertController(title: "Error", message: self.myDictionary["message"] as? String, preferredStyle: .alert)
                                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    } catch
                    {
                        print(error)
                    }
                }
            }.resume()
        } else {print("Error en la peticionRegister ")}
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Redondear IMG
        self.editarIMG.layer.cornerRadius = 55
        self.editarIMG.clipsToBounds = true
        
        // Redondear TextField
        self.descripcionTFr.layer.cornerRadius = 10
        self.descripcionTFr.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
