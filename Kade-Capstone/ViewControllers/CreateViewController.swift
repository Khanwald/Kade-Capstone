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
    
    @IBOutlet weak var deckName: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    //collectionView.widthAnchor.hashValue
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        var deckTerms:[String:String] = [:]
        for deck in data{
            deckTerms[deck.term] = deck.definition
        }
        
        
        
        
        let ref2 = Database.database().reference(withPath: "decks/\(ViewController.currentUser)/\(deckName)")
        ref2.setValue(deckTerms) { (error, ref) in
            if error != nil {
                print("error")
            } else {
                print("New Deck made")
            }
            
        }
        
        
    }
    @IBAction func addItem(_ sender: Any) {
    
        let alert = UIAlertController(title: "Add New Term", message: "Add a term and definition", preferredStyle: .alert)
    
        // TextFields in alert
        alert.addTextField { (term) in
            term.placeholder = "New term"
        }
    
        alert.addTextField { (definition) in
            definition.placeholder = "New definition"
        }
    
        // Action for alert
        // Saves text from action
        let okAction = UIAlertAction(title: "Add", style: .default) { [self] (action) in
            // handle response here.
    
            let textField = alert.textFields![0] as UITextField
            let textFieldA = alert.textFields![1] as UITextField
    
            guard let term = textField.text, let definition = textFieldA.text else{return}
    
            data.append(SetItem(term: term, definition: definition))
    
            let indexPath = IndexPath(row: self.data.count - 1, section: 0)
            self.collectionView.insertItems(at: [indexPath])
    
    
    
        }
    
        alert.addAction(okAction)
    
        self.present(alert, animated: true, completion: nil)
    
    
    }

}
extension CreateViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView( _ collectionView:UICollectionView, numberOfItemsInSection section:Int ) -> Int
    {
        return data.count
    }
    
    
    func collectionView( _ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.termLabel.text = data[indexPath.item].term
        cell.definitionLabel.text = data[indexPath.item].definition
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataPoint = self.data[indexPath.item]
        let alert = UIAlertController(title: "Edit", message: "Edit a term or definition", preferredStyle: .alert)
    
        // TextFields in alert
        alert.addTextField { (term) in
            term.placeholder = "\(dataPoint.term)"
        }
    
        alert.addTextField { (definition) in
            definition.placeholder = "\(dataPoint.definition)"
        }
    
        // Action for alert
        // Saves text from action
        let okAction = UIAlertAction(title: "Done", style: .default) { [self] (action) in
            // handle response here.
            
    
            let textField = alert.textFields![0] as UITextField
            let textFieldA = alert.textFields![1] as UITextField
    
            guard let term = textField.text, let definition = textFieldA.text else{return}
            if !term.isEmpty{
                self.data[indexPath.item].term = term
            }
            if !definition.isEmpty{
                self.data[indexPath.item].definition = definition
            }
            self.collectionView.reloadItems(at: [indexPath])
    
    
    
        }
    
        alert.addAction(okAction)
    
        self.present(alert, animated: true, completion: nil)
    
    }
    
}

//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Uncomment the following line to preserve selection between presentations
//    // self.clearsSelectionOnViewWillAppear = false
//
//    // Register cell classes
//    self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//    // Do any additional setup after loading the view.
//    self.collectionView!.reloadData()
//}
//
//
//@IBAction func addItem(_ sender: Any) {
//
//    let alert = UIAlertController(title: "Add New Item", message: "Add an item and definition", preferredStyle: .alert)
//
//    // TextFields in alert
//    alert.addTextField { (term) in
//        term.placeholder = "New term"
//    }
//
//    alert.addTextField { (definition) in
//        definition.placeholder = "New definition"
//    }
//
//    // Action for alert
//    // Saves text from action
//    let okAction = UIAlertAction(title: "Add", style: .default) { (action) in
//        // handle response here.
//
//        let textField = alert.textFields![0] as UITextField
//        let textFieldA = alert.textFields![1] as UITextField
//
//        guard let term = textField.text, let definition = textFieldA.text else{return}
//
//        self.arrayOfData.append(SetItem(term: term, definition: definition))
//
//        let indexPath = IndexPath(row: self.arrayOfData.count - 1, section: 0)
//        self.collectionView.insertItems(at: [indexPath])
//
//
//
//    }
//
//    alert.addAction(okAction)
//
//    self.present(alert, animated: true, completion: nil)
//
//
//}
//
///*
//// MARK: - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//// MARK: UICollectionViewDataSource
//
//override func numberOfSections(in collectionView: UICollectionView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    return 4
//}
//
//
//override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of items
//    return self.arrayOfData.count
//}
//
//override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
//
//    // Configure the cell
//    print(indexPath.item)
//    let stru = self.arrayOfData[indexPath.item]
////        cell.configure(with: stru.term , with: stru.definition)
//
//    let term = stru.term
//    let definition = stru.definition
//
//
//    return cell
//}
