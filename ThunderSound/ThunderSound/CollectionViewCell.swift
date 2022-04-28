//
//  CollectionViewCell.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class CollectionViewCell: UICollectionViewCell
{
    @IBOutlet var todoView: UIView!
    @IBOutlet var perfilIV: UIImageView!
    @IBOutlet var comentariosView: UIView!
    @IBOutlet var miComentarioIV: UIImageView!
    @IBOutlet var userNameLB: UILabel!
    @IBOutlet var dateLB: UILabel!
    @IBOutlet var phraseLB: UILabel!
    @IBOutlet var comentariosTotalesBT: UIButton!
    @IBOutlet var likeTotalesBT: UIButton!
    @IBOutlet var miComentarioNewTF: UITextField!
    @IBOutlet var enviarMiComentarioBT: UIButton!
}
