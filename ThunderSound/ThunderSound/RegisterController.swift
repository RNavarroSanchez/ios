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
        if emailTFr.text != nil && passTFr.text == passx2TFr.text && userTFr.text != nil && nameTFr.text != nil && subnameTFr.text != nil && descripcionTFr.text != nil
        {
            peticionRegister(emailTFr: emailTFr.text!, passTFr: passTFr.text!, passx2TFr: passx2TFr.text!, userTFr: userTFr.text!, nameTFr: nameTFr.text!, subnameTFr: subnameTFr.text!, descripcionTFr: descripcionTFr.text!, editarIMG: editarIMG.image!)// editarIMG: editarIMG.UIImageView!
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
        
    func peticionRegister(emailTFr: String, passTFr: String, passx2TFr: String, userTFr: String, nameTFr: String, subnameTFr: String, descripcionTFr: String, editarIMG: UIImage)//editarIMG: imagen //Peticion Registrar Usuario
    {
        let Url = String(format: "http://35.181.160.138/proyectos/thunder22/public/api/usuarios")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "correo=\(emailTFr)&password=\(passTFr)&nick=\(userTFr)&nombre=\(nameTFr)&apellidos=\(subnameTFr)&descripcion=\(descripcionTFr)&foto_url=\(editarIMG)" ///&foto_url=\(editarIMG.image ?? "")
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
                        print(json)
                        
                        if self.myDictionary["code"] as! Int == 200
                        {
                            let alert = UIAlertController(title: "LLego el momento...", message: "Registro completado con éxito", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "Loginid") as! LoginController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            
                        } else
                        {
                            let alert = UIAlertController(title: "Error != 200", message: self.myDictionary["message"] as? String, preferredStyle: .alert)
                            let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true)
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
