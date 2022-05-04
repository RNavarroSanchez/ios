//
//  SearchController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class SearchController: UIViewController
{
    @IBOutlet var searchBT: UIButton!
    @IBOutlet var searchTF: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Redondear searchBT
        let path = UIBezierPath(roundedRect:searchBT.bounds,
                                byRoundingCorners:[.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 6, height:  6))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        searchBT.layer.mask = maskLayer
    }

}
