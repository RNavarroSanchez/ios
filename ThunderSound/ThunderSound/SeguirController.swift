//
//  SeguirController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class SeguirController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet var userNameLBf: UILabel!
    @IBOutlet var profileIVf: UIImageView!
    @IBOutlet var followersLBf: UILabel!
    @IBOutlet var followLBf: UILabel!
    @IBOutlet var postLBf: UILabel!
    @IBOutlet var descriptionLBf: UILabel!
    @IBOutlet var postsCV: UICollectionView!
    @IBAction func followBTf(_ sender: Any)
    {
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    var posts: [[String: Any]] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postsCell", for: indexPath) as! PerfilCollectionViewCell
        let url = NSURL(string: posts[indexPath.row]["url_portada"] as! String)
        let data = NSData(contentsOf: url! as URL)
        if data != nil
        {
            cell.postIMG.image = UIImage(data: data! as Data)
        }
        cell.postNameLB.text = (posts[indexPath.row]["titulo"] as! String)
        return cell
    }
    
    var datos1: [String: Any] = [:]
    func peticionPerfil(id: Int)
    {
        let urlString = "http://35.181.160.138/proyectos/thunder22/public/api/usuarios/\(id)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            
            if response != nil
            {
                print(response ?? "No se han obtenido respuesta")
            }

            guard let data = data else { return }

            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String:Any]
                self.datos1 = json
                
                if self.datos1["error"] as? String == nil
                {
                    self.posts = self.datos1["data"] as! [[String : Any]]//Could not cast value of type '__NSDictionaryI' (0x101d10660) to 'NSArray' (0x101d106c0).
                    DispatchQueue.main.async
                    {
                        self.rellenarDatos()
                        self.postsCV.reloadData()
                    }
                } else
                {
                    let alert = UIAlertController(title: "No ha sido posible cargar el perfil", message: self.datos1["message"] as? String, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Entendido", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            } catch let jsonError { print(jsonError) }
        }.resume()
    }
    
    func rellenarDatos()
    {
        userNameLBf.text = (self.datos1["nick"] as! String)
        profileIVf.image = UIImage(data: self.datos1["foto_url"] as! Data)
        followersLBf.text = (self.datos1["numeroseguidores"] as! String)
        followLBf.text = (self.datos1["numeroseguidos"] as! String)
        postLBf.text = (self.datos1["numeroposts"] as! String)
        descriptionLBf.text = (self.datos1["descripcion"] as! String)
    }
    
}
