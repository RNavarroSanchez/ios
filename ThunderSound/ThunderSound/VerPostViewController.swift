//
//  VerPostViewController.swift
//  ThunderSound
//
//  Created by A1-IMAC08 on 3/6/22.
//

import UIKit
import WebKit

class VerPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBAction func backBT(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet var userPostIMG: UIImageView!
    @IBOutlet var nickLB: UILabel!
    @IBOutlet var horaCreacionLB: UILabel!
    @IBOutlet var textoLB: UILabel!
    @IBOutlet var spotifyWebView: WKWebView!
    @IBOutlet var comentariosTotalLB: UIButton!
    @IBOutlet var comentariosTV: UITableView!
    @IBOutlet var myUserIMG: UIImageView!
    @IBOutlet var comentarioTF: UITextField!
    @IBAction func enviarComentarioBT(_ sender: Any)
    {
        peticionAddComentario(comentarioTF: comentarioTF.text!)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        comentariosTV.delegate = self
        comentariosTV.dataSource = self
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        let shared = UserDefaults.standard
        spotifyWebView.loadHTMLString("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Document</title></head><body><iframe style=\"border-radius:12px\" src=\"https://open.spotify.com/embed/track/\(shared.string(forKey: "songid")!)?utm_source=generator\" width=\"100%\" height=\"90%\" frameBorder=\"0\" allowfullscreen=\"\" allow=\"autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture\"></iframe></body></html>"
                                       , baseURL: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 125
    }
    
    var posts: [[String: Any]] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verPostCell", for: indexPath) as! VerPostTableViewCell
        let url = NSURL(string: posts[indexPath.row]["foto_url"] as! String)
        let data = NSData(contentsOf: url! as URL)
        if data != nil
        {
            cell.userIV.image = UIImage(data: data! as Data)
        }
        cell.nickLB.text = (posts[indexPath.row]["nick"] as! String)
        cell.comentarioLB.text = (posts[indexPath.row]["comentario"] as! String)
        return cell
    }//ESTO DEBERIA DE ESTAR BIEN PUESTO, PERO DEBO DE MODIFICAR LAS CLAVES CAUNDO SEPA LA PETICION
    
    var myComents: [String: Any] = [:]
    func peticionAddComentario(comentarioTF: String)
    {
        let Url = String(format: "")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "password=\(comentarioTF)" //esto aun no lo se, tengo que esperar a la peticion
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{print(response)}
            if let data = data
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async
                    {
                        self.myComents = json as! [String: Any]
                        print(json)
                        
                        if self.myComents["error"] as? String == nil
                        {
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let vc = storyboard.instantiateViewController(withIdentifier: "Profileid") as! PerfilController
//                            vc.modalPresentationStyle = .fullScreen
//                            self.present(vc, animated: true, completion: nil)
                        } else
                        {
                            let alert = UIAlertController(title: "Error != 200", message: self.myComents["message"] as? String, preferredStyle: .alert)
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
