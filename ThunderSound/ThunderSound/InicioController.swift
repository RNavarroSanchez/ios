//
//  InicioController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class InicioController: UIViewController
{
    @IBOutlet var todoView: UIView!
    @IBOutlet var perfilIMG: UIImageView!
    @IBOutlet var comentariosView: UIView!
    @IBOutlet var comentarioIMG: UIImageView!
    @IBOutlet var miComentarioIMG: UIImageView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Redondear cajaTotal
        self.todoView.layer.cornerRadius = 5
        self.todoView.clipsToBounds = true
        
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
}
