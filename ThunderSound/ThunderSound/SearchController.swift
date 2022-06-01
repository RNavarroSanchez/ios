//
//  SearchController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchEditBT: UIButton!
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let path = UIBezierPath(roundedRect:searchEditBT.bounds,
                                byRoundingCorners:[.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 6, height:  6))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        searchEditBT.layer.mask = maskLayer
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        usuarios.count
    }
    
    var usuarios: [[String: Any]] = []
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! SearchTableViewCell
        let url = NSURL(string: usuarios[indexPath.row]["foto_url"] as! String)
        let data = NSData(contentsOf: url! as URL)
        if data != nil
        {
            cell.perfilIMG.image = UIImage(data: data! as Data)
        }
        cell.nameLB.text = (usuarios[indexPath.row]["nombre"] as! String)
        cell.nickLB.text = (usuarios[indexPath.row]["nick"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let id = (usuarios[indexPath.row]["id"] as! Int)
        let shared = UserDefaults.standard
        shared.setValue(id, forKey: "id")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "suPerfilid") as! SeguirController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
        request.setValue("Bearer \(shared.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
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
                    
                    self.mySearch = json as! [String: Any]
                    print(json)
                    
                    if self.mySearch["error"] as? String == nil
                    {
                        self.usuarios = self.mySearch["data"] as! [[String: Any]]
                        DispatchQueue.main.async
                        {
                            self.tableView.reloadData()
                        }
                    } else
                    {
                        let alert = UIAlertController(title: "Error != 200", message: self.mySearch["message"] as? String, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    }
                } catch
                {
                    print(error)
                }
            }
        }.resume()
    }
}
