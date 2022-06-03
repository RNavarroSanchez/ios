//
//  SearchPostController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit
import WebKit

class SearchPostController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var searchBT: UIButton!
    @IBAction func searchBT(_ sender: Any)
    {
        if searchTF.text != nil
        {
            peticionSearchSong(searchTF: searchTF.text!)
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
        
        let path = UIBezierPath(roundedRect:searchBT.bounds,
                                byRoundingCorners:[.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 6, height:  6))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        searchBT.layer.mask = maskLayer
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    var songs: [[String: Any]] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchPostCell", for: indexPath) as! SearchPostTableViewCell
        let id_track = self.songs[indexPath.row]["id"]!
        let shared = UserDefaults.standard
        shared.setValue(id_track, forKey: "songid")

        cell.spotifyWebView.loadHTMLString("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Document</title></head><body><iframe style=\"border-radius:12px\" src=\"https://open.spotify.com/embed/track/\( id_track)?utm_source=generator\" width=\"100%\" height=\"50%\" frameBorder=\"0\" allowfullscreen=\"\" allow=\"autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture\"></iframe></body></html>"
                                      , baseURL: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreatePostid") as! AlertController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    var mySearch: [String: Any] = [:]
    func peticionSearchSong(searchTF: String)
    {
        let Url = String(format: "https://v1.nocodeapi.com/thundersound/spotify/KXtTVPLnmLOAqHgA/search?q=\(searchTF)&type=track&perPage=6")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
                        let dataG = self.mySearch["tracks"] as! [String: Any]
                        self.songs = dataG["items"] as! [[String : Any]]
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
