//
//  NotificacionesController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class NotificacionesController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var notificationTV: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notificationTV.delegate = self
        notificationTV.dataSource = self
        
//        peticionGetNotif(id: self.usuarios[indexPath.row]) // como saco el id del user?
    }

    var usuarios: [[String: Any]] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell", for: indexPath) as! NotifTableViewCell
        let url = NSURL(string: usuarios[indexPath.row]["image"] as! String)
        let data = NSData(contentsOf: url! as URL)
        if data != nil
        {
            cell.iconNotifIMG.image = UIImage(data: data! as Data)
        }
        cell.textoNotifTV.text = (usuarios[indexPath.row]["tipo"] as! String)
//        if cell.textoNotifTV.text == "COMENTARIO"
//        {
//            cell.textoNotifTV.text = (usuarios[indexPath.row]["tipo"] as! String)
//        }
        self.view.backgroundColor = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
        
        
        return cell
    }
    
    var myNotif: [String: Any] = [:]
    func peticionGetNotif(id: Int)
    {
        let shared = UserDefaults.standard
        let Url = String(format: "http://35.181.160.138/proyectos/thunder22/public/api/usuarios/\(id)/notificaciones")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.setValue("Bearer \(shared.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")

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
                    print(json)
                    
                    self.myNotif = json as! [String: Any]
                    if self.myNotif["error"] as? String == nil
                    {
                        self.usuarios = self.myNotif["data"] as! [[String: Any]]
                        DispatchQueue.main.async
                        {
                            self.notificationTV.reloadData()
                        }
                    } else
                    {
                        let alert = UIAlertController(title: "No ha recibido ninguna notificación.", message: self.myNotif["message"] as? String, preferredStyle: .alert)
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
