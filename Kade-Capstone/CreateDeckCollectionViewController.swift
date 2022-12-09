//
//  CreateDeckCollectionViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/9/22.
//

import UIKit

private let reuseIdentifier = "cell"

var arrayOfData:[SetItem] = []
var count = arrayOfData.count

class CreateDeckCollectionViewController: UICollectionViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.collectionView!.reloadData()
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add New Item", message: "Add an item and definition", preferredStyle: .alert)
        
        // TextFields in alert
        alert.addTextField { (term) in
            term.placeholder = "New term"
        }
        
        alert.addTextField { (definition) in
            definition.placeholder = "New definition"
        }
        
        // Action for alert
        // Saves text from action
        let okAction = UIAlertAction(title: "Add", style: .default) { (action) in
            // handle response here.
        
            let textField = alert.textFields![0] as UITextField
            let textFieldA = alert.textFields![1] as UITextField
        
            guard let term = textField.text, let definition = textFieldA.text else{return}
            
            arrayOfData.append(SetItem(term: term, definition: definition))
            
            
            
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        let stru = arrayOfData[indexPath.item]
        cell.configure(with: stru.term , with: stru.definition)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
