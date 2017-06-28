//
//  Person.swift
//  TrialTinder
//
//  Created by Laura Calinoiu on 28/06/2017.
//  Copyright © 2017 3smurfs.com. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Person: NSObject {
    
    var name: String
    var intro: String
    var image: String
    var imageData: Data?
    
    init(nickname: String, name: String, intro: String, image: String) {
        self.name = name
        self.intro = intro
        self.image = image
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: String] else { return nil }
        guard let name  = dict["name"]  else { return nil }
        guard let intro = dict["intro"] else { return nil }
        guard let image = dict["image"] else { return nil }
        
        self.name = name
        self.intro = intro
        self.image = image
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "intro": intro,
            "image": image
        ]
    }
    
}
