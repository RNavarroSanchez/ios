//
//  InicioController.swift
//  ThunderSound
//
//  Created by A1-IMAC08 on 25/4/22.
//

import UIKit

class InicioController: UIViewController
{
    @IBOutlet var collectionViewCell: UICollectionViewCell!
    @IBOutlet var perfilIMG: UIImageView!
    @IBOutlet var comentariosView: UIView!
    @IBOutlet var comentarioIMG: UIImageView!
    @IBOutlet var miComentarioIMG: UIImageView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // Redondear cajaTotal
    self.collectionViewCell.layer.cornerRadius = 10
    self.collectionViewCell.clipsToBounds = true
    
    // Redondear perfilIMG
    self.perfilIMG.layer.cornerRadius = 10
    self.perfilIMG.clipsToBounds = true
    
    // Redondear caja de abajo
    self.comentariosView.layer.cornerRadius = 10
    self.comentariosView.clipsToBounds = true
    
    // Redondear otroComentarioIMG
    self.comentarioIMG.layer.cornerRadius = 10
    self.comentarioIMG.clipsToBounds = true
    
    // Redondear miCOmentarioIMG
    self.miComentarioIMG.layer.cornerRadius = 10
    self.miComentarioIMG.clipsToBounds = true
    

}
