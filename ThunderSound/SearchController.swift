//
//  SearchController.swift
//  ThunderSound
//
//  Created by A1-IMAC08 on 23/3/22.
//

import UIKit

///ESTO ES PARA HACER UNA BARRA DE PROGRESO Y DEJARLA AL TOPE PARA LAS  TARJETAS DE BUSQUEDA DE CANCION
//struct ContentView: View
//{
//    @State private var downloadAmount = 0.0
//
//    var body: some View {
//        VStack {
//            ProgressView("Downloading…", value: downloadAmount, total: 100)
//        }
//    }
//}

class SearchController: UIViewController
{
    @IBOutlet var searchBT: UIButton!
    @IBOutlet var searchTF: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Redondear TextField
        self.searchBT.layer.cornerRadius = 5
        self.searchBT.layer.borderWidth = 1
        self.searchBT.clipsToBounds = true
    }

}
