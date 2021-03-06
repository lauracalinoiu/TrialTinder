//
//  ViewController.swift
//  TrialTinder
//
//  Created by Laura Calinoiu on 28/06/2017.
//  Copyright © 2017 3smurfs.com. All rights reserved.
//

import UIKit
import Koloda
import FirebaseDatabase

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    var persons: [Person] = []
    var ref: DatabaseReference!
    let dispatch_group = DispatchGroup()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        activityIndicator.startAnimating()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        self.ref = Database.database().reference()
        
        loadAllPersonsWithImages {
            self.kolodaView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        
    }
    
    func loadAllPersonsWithImages (completion: @escaping () -> () ) {
        loadAllPersons (){
            for person in self.persons {
                self.dispatch_group.enter()
                URLSession.shared.dataTask(with: NSURL(string: person.image)! as URL, completionHandler: { (data, response, error) -> Void in
                    
                    guard error == nil else { return }
                    DispatchQueue.main.async(execute: { () -> Void in
                        person.imageData = data
                        self.dispatch_group.leave()
                    })
                    
                }).resume()
                
            }
            
            self.dispatch_group.notify(queue: DispatchQueue.main) {
                print("All Done")
                completion()
            }
        }

    }

    func loadAllPersons(completion: @escaping () -> () ) {
        _ = ref.child("persons").observeSingleEvent(of: .value, with: {(snapshot) in
            for child in snapshot.children.allObjects {
                
                if let snap = child as? DataSnapshot, let person = Person(snapshot: snap) {
                    self.persons.append(person)
                }
            }
            
            completion()
        })
    }
}

extension SwipeViewController: KolodaViewDelegate {
    
    func koloda(koloda: KolodaView, didSelectCardAt index: Int) {
        //segue to detail
    }
}

extension SwipeViewController: KolodaViewDataSource {
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return persons.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        //return UIImageView(image: UIImage(data: persons[index].imageData!))
        let swipeCardView = Bundle.main.loadNibNamed("SwipeCardView", owner: self, options: nil)?.first as! SwipeCardView
        swipeCardView.person = persons[index]
        return swipeCardView
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView",
                                                  owner: self, options: nil)?[0] as? OverlayView
    }
}
