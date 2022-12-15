//
//  HomeViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/10/22.
//

import UIKit
import FirebaseDatabase
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var deckCollectionView: UICollectionView!
    
    var array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let layout1 = deckCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout1.scrollDirection = .horizontal
        deckCollectionView.delegate = self
        deckCollectionView.dataSource = self
        
        observe()

    
    }
    
    
//Observe function that initalizes collection view cells with deck names from user
    func observe(){
        
        let data = Database.database().reference().child("decks")

        data.child(ViewController.User.currentUser).observe(DataEventType.value) { [self] (snapshot) in
            self.array.removeAll()
            for childSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                let name = childSnapshot.key
                self.array.append(name)
                print(name)
                
            }
            deckCollectionView.reloadData()
        }
    }
    
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView( _ collectionView:UICollectionView, numberOfItemsInSection section:Int ) -> Int
    {
    
        return self.array.count
    }


    func collectionView( _ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = deckCollectionView.dequeueReusableCell(withReuseIdentifier: "set", for: indexPath) as! DeckCollectionViewCell
        

        cell.deckNameLabel.text = array[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cool")

    }
    
}
