//
//  AccessViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/21/22.
//

import UIKit
import Firebase
class AccessViewController: UIViewController {
    
    static var deck:[String:String] = [:]
    
    static var name = " "
    var terms: [SetItem] = []
    
    @IBOutlet var setLabel: UILabel!
    @IBOutlet var tAndD: UICollectionView!
    
    override func viewDidLoad() {
        setLabel.text = AccessViewController.name
        AccessViewController.deck.removeAll()
        layout()
        
        let ref = Database.database().reference().child("decks").child(ViewController.User.currentUser).child(AccessViewController.name)
        
        ref.observeSingleEvent(of: .value){ snapshot in
            print(snapshot)
            for childSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                let term = childSnapshot.key
                let def = childSnapshot.value
                
                self.terms.append(SetItem(term: term, definition: def as! String))
                
            }
            self.tAndD.reloadData()
    
        }
        
        
    }
    
    func layout(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 390, height: 120)
        tAndD.collectionViewLayout = layout
        
        tAndD.delegate = self
        tAndD.dataSource = self
    }
    
    @IBAction func crosswordButton(_ sender: Any) {
        if let visibleCells = tAndD.visibleCells as? [CollectionViewCell] {
            visibleCells.forEach { cell in
                // do something with each cell
                if let term = cell.termLabel.text, let def = cell.definitionLabel.text {
                    AccessViewController.deck[term] = def
                }
            }
            
        }
        print(AccessViewController.deck)
    }
    
}
extension AccessViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView( _ collectionView:UICollectionView, numberOfItemsInSection section:Int ) -> Int
    {
        terms.count
    }
    
    
    func collectionView( _ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let item = terms[indexPath.item]
        cell.configure(with: item.term, with: item.definition)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}
