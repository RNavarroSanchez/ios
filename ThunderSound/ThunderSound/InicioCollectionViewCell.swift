//
//  CollectionViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit
import WebKit

class InicioCollectionViewCell: UICollectionViewCell
{
    @IBOutlet var todoView: UIView!
    @IBOutlet var perfilIV: UIImageView!
    @IBOutlet var userNameLB: UILabel!
    @IBOutlet var dateLB: UILabel!
    @IBOutlet var phraseLB: UILabel!
    @IBOutlet var comentariosTotalesBT: UIButton!
    @IBOutlet var likeTotalesBT: UIButton!
    @IBOutlet var comentariosView: UIView!
    @IBOutlet var miComentarioIV: UIImageView!
    @IBOutlet var miComentarioNewTF: UITextField!
    @IBOutlet var enviarMiComentarioBT: UIButton!
    @IBOutlet var InicioWebView: WKWebView!
    
    
    func girarimagen(_ sender: Any)
    {
        enviarMiComentarioBT.transform = enviarMiComentarioBT.transform.rotated(by: CGFloat(Double.pi / 6))
    }

}
