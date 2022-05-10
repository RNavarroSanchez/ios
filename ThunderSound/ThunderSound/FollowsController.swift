//
//  FollowsController.swift
//  ThunderSound
//
//  Created by Juanjo
//

import UIKit

class FollowsController: UIViewController
{
    @IBOutlet var backBBI: UIBarButtonItem!
//    @IBAction func didtapSegment(_ sender: Any)
//    {
//      Asi es como me lo crea solo y abajo como he visgo que se declara pero no se si estara deprecated
//    }
    
    @IBAction func didTapSegment(segment: UISegmentedControl)
    {
        seguidoresVC.view.isHidden = true
        seguidosVC.view.isHidden = true
        
        if segment.selectedSegmentIndex == 0
        {
            seguidoresVC.view.isHidden = false
        } else
        {
            seguidosVC.view.isHidden = false      
        }
    }
    
    let seguidoresVC = SeguidoresController()
    let seguidosVC = SeguidosController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setup()
    }
    
    private func setup()
    {
        addChild(seguidoresVC)
        addChild(seguidosVC)
        self.view.addSubview(seguidoresVC.view)
        self.view.addSubview(seguidosVC.view)
        
        seguidoresVC.didMove(toParent: self)
        seguidosVC.didMove(toParent: self)
        
        seguidoresVC.view.frame = self.view.bounds
        seguidosVC.view.frame = self.view.bounds
        seguidosVC.view.isHidden = true
    }
}
