//
//  PerfilController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class PerfilController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet var userNameLBp: UILabel!
    @IBOutlet var myProfileIVp: UIImageView!
    @IBOutlet var followersLBp: UILabel!
    @IBOutlet var followLBp: UILabel!
    @IBOutlet var postLBp: UILabel!
    @IBOutlet var descriptionLBp: UILabel!
    @IBAction func editeBTp(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Editid") as! EditProfileController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func logoutBTp(_ sender: Any)
    {
        let shared = UserDefaults.standard
        shared.setValue("", forKey: "userTF")
        shared.setValue("", forKey: "passwordTF")
        shared.setValue("", forKey: "token")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Loginid") as! LoginController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet var postCV: UICollectionView!
    var posts: [[String: Any]] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let shared = UserDefaults.standard
        peticionPerfil(id: shared.integer(forKey: "id"))
    }
    
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
                    //self.posts = self.datos1["data"] as! [[String : Any]]Could not cast value of type '__NSDictionaryI' (0x101d10660) to 'NSArray' (0x101d106c0).
                    DispatchQueue.main.async
                    {
//                        self.rellenarDatos()
                        self.postCV.reloadData()
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
    
//    func rellenarDatos()
//    {
//        userNameLBp.text = (self.datos1["nick"] as! String)
//        myProfileIVp.image = UIImage(data: self.datos1["foto_url"] as! Data)
//        followersLBp.text = (self.datos1["numeroseguidores"] as! String)
//        followLBp.text = (self.datos1["numeroseguidos"] as! String)
//        postLBp.text = (self.datos1["numeroposts"] as! String)
//        descriptionLBp.text = (self.datos1["descripcion"] as! String)
//    }

}
