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
    var likes: [Chat]?
    
    init(name: String, intro: String, image: String, likes: [Chat]) {
        self.name = name
        self.intro = intro
        self.image = image
        self.likes = likes
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let name  = dict["name"]  as? String else { return nil }
        guard let intro = dict["intro"] as? String else { return nil }
        guard let image = dict["image"] as? String else { return nil }
        
        self.name = name
        self.intro = intro
        self.image = image
        
        guard let likesDict = snapshot.childSnapshot(forPath: "likes").value as? [String: Any] else { return }
        
        likes = []
        for like in  likesDict {
            guard let chat = like.value as? [String: Any] else { return }
            self.likes?.append(Chat(chat["name_of_chat"] as! String))
        }
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "intro": intro,
            "image": image
        ]
    }
    
}
