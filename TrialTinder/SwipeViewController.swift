//
//  ViewController.swift
//  TrialTinder
//
//  Created by Laura Calinoiu on 28/06/2017.
//  Copyright © 2017 3smurfs.com. All rights reserved.
//

import UIKit
import Koloda

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    let images = ["portret2", "portret"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }

}

extension SwipeViewController: KolodaViewDelegate {
 
    func koloda(koloda: KolodaView, didSelectCardAt index: Int) {
        //segue to detail page
    }
}

extension SwipeViewController: KolodaViewDataSource {
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: UIImage(named: images[index]))
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView",
                                                  owner: self, options: nil)?[0] as? OverlayView
    }
}
