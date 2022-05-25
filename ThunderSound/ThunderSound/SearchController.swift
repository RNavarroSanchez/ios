//
//  SearchController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class SearchController: UIViewController
{
    @IBOutlet var searchTF: UITextField!
    @IBAction func searchBT(_ sender: Any)
    {
        if searchTF.text != nil
        {
            peticionSearchUser(searchTF: searchTF.text!)
        } else
        {
            let alert = UIAlertController(title: "Error", message: "Por favor, rellene el campo para realizar la búsqueda.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
//http://35.181.160.138/proyectos/thunder22/public/api/buscar
    override func viewDidLoad()
    {
        super.viewDidLoad()
// ya no funciona porque es una accion y no una variable
//        // Redondear searchBT
//        let path = UIBezierPath(roundedRect:searchBT.bounds,
//                                byRoundingCorners:[.topRight, .bottomRight],
//                                cornerRadii: CGSize(width: 6, height:  6))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        searchBT.layer.mask = maskLayer
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    var mySearch: [String: Any] = [:]
    func peticionSearchUser(searchTF: String)
    {
        let shared = UserDefaults.standard
        let Url = String(format: "http://35.181.160.138/proyectos/thunder22/public/api/buscar")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "nick=\(searchTF)"
       
        request.setValue("Bearer \(shared.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")//shared.string(forKey: "token") o como
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
                        self.mySearch = json as! [String: Any]
                        print(json)
                        
                        if self.mySearch["error"] as? String == nil
                        {
                            print("todo ok")
                            print(shared.string(forKey: "token"))
                        } else
                        {
                            let alert = UIAlertController(title: "Error != 200", message: self.mySearch["message"] as? String, preferredStyle: .alert)
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
