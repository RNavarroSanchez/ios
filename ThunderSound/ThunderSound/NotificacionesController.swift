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
    var myNotif: [String: Any] = [:]
    var usuarios: [[String: Any]] = []
    
    override func viewDidLoad()
    {
        notificationTV.delegate = self
        notificationTV.dataSource = self
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell", for: indexPath) as! NotifTableViewCell
       
        let url = NSURL(string: usuarios[indexPath.row]["image"] as! String)
        let data = NSData(contentsOf: url! as URL)
        if data != nil {
            cell.iconNotifIMG.image = UIImage(data: data! as Data)
        }
        
        cell.textoNotifTV.text = (usuarios[indexPath.row]["tipo"] as! String)
        
        return cell
    }
}
