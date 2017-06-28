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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }

}

extension SwipeViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        //dataSource.reset()
        print("Run out of cards!")
    }
    
    func koloda(koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://yalantis.com/")!)
    }
}

extension SwipeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> Int {
        return images.count
    }
    
    func koloda(koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: images[index])
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}
