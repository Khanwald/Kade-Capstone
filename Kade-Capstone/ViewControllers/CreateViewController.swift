//
//  CreateViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/10/22.
//



import UIKit
import FirebaseDatabase
import FirebaseAuth

class CreateViewController: UIViewController {
    var data:[SetItem] = []
    var count = 1
    @IBOutlet weak var deckName: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    //collectionView.widthAnchor.hashValue
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .clear

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 390, height: 90)
        collectionView.collectionViewLayout = layout
        
        // Set the scroll direction to horizontal
        let layout1 = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout1.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    @IBAction func createDeck(_ sender: Any) {
        guard let deckName = deckName.text, !deckName.isEmpty else {return}

        if let visibleCells = collectionView.visibleCells as? [CreateCollectionViewCell] {
            visibleCells.forEach { cell in
                // do something with each cell
                if let term = cell.term.text, let def = cell.definition.text {
                    data.append(SetItem(term: term, definition: def))
                }
            }
        }


        var deckTerms:[String:String] = [:]
        for deck in data{
            deckTerms[deck.term] = deck.definition
        }
        
        
        
        
        let ref2 = Database.database().reference(withPath: "decks/\(ViewController.User.currentUser)/\(deckName)")
        ref2.setValue(deckTerms) { (error, ref) in
            if error != nil {
                print("error")
            } else {
                print("New Deck made")
            }
            
        }
        
        
    }
    @IBAction func addItem(_ sender: Any) {
        count += 1
        let indexPath = IndexPath(row: count - 1, section: 0)
        self.collectionView.insertItems(at: [indexPath])
    
    
    }

}
extension CreateViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView( _ collectionView:UICollectionView, numberOfItemsInSection section:Int ) -> Int
    {
        return count
    }
    
    
    func collectionView( _ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTerm", for: indexPath) as! CreateCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}
