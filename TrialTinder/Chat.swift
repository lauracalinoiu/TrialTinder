//
//  Likes.swift
//  TrialTinder
//
//  Created by Laura Calinoiu on 28/06/2017.
//  Copyright © 2017 3smurfs.com. All rights reserved.
//

import Foundation

class Chat: NSObject {
    var nameOfChat: String = ""
    
    init(_ nameOfChat: String) {
        self.nameOfChat = nameOfChat
    }
    
    func toAnyObject() -> Any {
        return ["name_of_chat": nameOfChat]
    }
}
