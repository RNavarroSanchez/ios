////
////  Inicio1ViewController.swift
////  ThunderSound
////
////  Created by A1-IMAC08 on 8/6/22.
////
//
//import UIKit
//
//class Inicio1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
//{
//    @IBOutlet var inicioTableView: UITableView!
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        posts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath -> UITableViewCell
//    {
//        let cell = inicioTableView.dequeueReusableCell(withIdentifier: "inicio1Cell", for: indexPath) as! Inicio1ViewController
//        let url = NSURL(string: posts[indexPath.row]["foto_url"] as! String)
//        let data = NSData(contentsOf: url! as URL)
//        if data != nil
//        {
//            cell.perfilIV.image = UIImage(data: data! as Data)
//        }
//        cell.usernameLB.text = (posts[indexPath.row]["nick"] as! String)
//        cell.phraseLB.text = (posts[indexPath.row]["texto"] as! String)
//        let numComent = (posts[indexPath.row]["nunmero_comentarios"])!
//        cell.comentariosTotalesBT.setTitle("\(numComent)", for: .normal)
//        let dataC = (posts[indexPath.row ]["cancion"] as! [String : Any])
//        let songID = dataC["spotify_id"] as! String
//        cell.InicioWebView.loadHTMLString("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Document</title></head><body style = \"background-color:#FC9025\"><iframe style=\"border-radius:12px\" src=\"https://open.spotify.com/embed/track/\(songID)?utm_source=generator\" width=\"100%\" height=\"100%\" frameBorder=\"0\" allowfullscreen=\"\" allow=\"autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture\"></iframe></body></html>", baseURL: nil)
//        cell.todoView.layer.cornerRadius = 15
//        cell.todoView.clipsToBounds = true
//        cell.perfilIV.layer.cornerRadius = 20
//        cell.perfilIV.clipsToBounds = true
//        return cell
//    }
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        inicioTableView.delegate = self
//        inicioTableView.dataSource = self
//        let shared = UserDefaults.standard
//        peticionPerfil(id: shared.integer(forKey: "id"))
//    }
//
//    var posts: [[String: Any]] = []
//    var datos1: [String: Any] = [:]
//    func peticionPerfil(id: Int)
//    {
//        let shared = UserDefaults.standard
//        let urlString = "http://35.181.160.138/proyectos/thunder22/public/api/usuarios/1/siguiendo"
//        guard let serviceUrl = URL(string: urlString) else { return }
//        var request = URLRequest(url: serviceUrl)
//        let token = (shared.string(forKey: "token")!)
//        print(token)
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if error != nil
//            {
//                print(error!.localizedDescription)
//            }
//            if response != nil
//            {
//                print(response ?? "No se han obtenido respuesta")
//            }
//            guard let data = data else { return }
//            do
//            {
//                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String:Any]
//                self.datos1 = json
//                if self.datos1["error"] as? String == nil
//                {
//                    print(self.datos1)
//                    let dataG = self.datos1["data"] as! [String: Any]
//                    self.posts = dataG["data"] as! [[String : Any]]
//
//                    DispatchQueue.main.async
//                    {
//                        self.inicioTableView.reloadData()
//                    }
//                } else
//                {
//                    let alert = UIAlertController(title: "No ha sido posible cargar el perfil", message: self.datos1["message"] as? String, preferredStyle: .alert)
//                    let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
//                    alert.addAction(action)
//                    self.present(alert, animated: true)
//                }
//            } catch let jsonError { print(jsonError) }
//        }.resume()
//    }
//}
