//
//  SearchPostController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class SearchPostController: UIViewController, UITableViewDelegate
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
        //tableView.dataSource = self
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
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//
//    }
    
    var mySearch: [String: Any] = [:]
    func peticionSearchSong(searchTF: String)
    {
        let shared = UserDefaults.standard
        let Url = String(format: "https://v1.nocodeapi.com/thundersound/spotify/KXtTVPLnmLOAqHgA")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "q=\(searchTF)"
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
                        self.songs = self.mySearch["data"] as! [[String: Any]]
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
