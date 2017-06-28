//
//  SwipeCardView.swift
//  TrialTinder
//
//  Created by Laura Calinoiu on 28/06/2017.
//  Copyright © 2017 3smurfs.com. All rights reserved.
//

import UIKit
import Koloda

class SwipeCardView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var person: Person? {
        didSet {
            guard person != nil else { return }
            if let person = person {
                self.imageView.image = UIImage(data: person.imageData!)
                self.nameLabel.text = person.name
                self.introLabel.text = person.intro
            }
        }
    }
}
