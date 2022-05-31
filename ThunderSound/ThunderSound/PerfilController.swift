//
//  PerfilController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class PerfilController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var datos1: Array<String> = []
    
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
    
    func peticionPerfil()
    {
        let urlString = "http://35.181.160.138/proyectos/thunder22/public/api/usuarios/id/canciones"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            
            if response != nil
            {
                print(response ?? "No se ha obtenido respuesta")
            }

            guard let data = data else { return }

            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String:Any]
                self.datos1 = json["characters"] as! Array<String>
                
                DispatchQueue.main.async
                {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "inicio") as! ViewController
//                    vc.datos1 = self.nCharacters
//                    self.navigationController?.show(vc, sender: nil)
                }
            } catch let jsonError { print(jsonError) }
        }.resume()
    }

}
