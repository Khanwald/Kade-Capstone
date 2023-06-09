//
//  CreateViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/10/22.
//



import UIKit
import FirebaseDatabase
import FirebaseAuth
import Foundation
class CreateViewController: UIViewController {
    
    var deckID = " "
    var code = " "
    
    
    var data:[SetItem] = []
    var count = 1
    @IBOutlet weak var deckName: UITextField!
    
    @IBOutlet weak var shareDeckSwitch: UISwitch!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        deckID = generateUniqueDeckID()
        print(deckID)
        
        fetchSchool { [weak self] (school) in
            if let school = school {
                // User is enrolled in a school, handle the data
                self?.shareDeckSwitch.isHidden = false
            } else {
                // User is not enrolled in a school, handle the absence of data
                self?.shareDeckSwitch.isHidden = true
            }
        }
        
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
        
        KeyboardHelper.addKeyboardDismissRecognizer(to: view)
        
        // Register for the UIKeyboardWillShowNotification and UIKeyboardWillHideNotification notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func fetchSchool(completion: @escaping (String?) -> Void) {
        var ref: DatabaseReference
        ref = Database.database().reference(withPath: "users")
        
        // Obtains the school code if there is one
        ref.child(ViewController.User.currentUser).child("schoolCode").observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? String {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        // Get the keyboard height and adjust the content inset of the collection view
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            collectionView.contentInset = contentInset
            collectionView.scrollIndicatorInsets = contentInset
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // Reset the content inset of the collection view
        let contentInset = UIEdgeInsets.zero
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = contentInset
    }

    
    @IBAction func exitKeyboard(_ sender: Any) {
        
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
        
        
        
        
        let ref2 = Database.database().reference(withPath: "decks/\(ViewController.User.currentUser)/\(deckName)/data")
        ref2.setValue(deckTerms) { (error, ref) in
            if error != nil {
                print("error")
            } else {
                print("New Deck made")
            }
            
        }
        if shareDeckSwitch.isOn{
            fetchSchool { [weak self] (school) in
                if let school = school {
                    // User is enrolled in a school, handle the data
                    let ref3 = Database.database().reference(withPath: "schools/\(school)/decks/\(self!.deckID)")
                    ref3.setValue(["creator": ViewController.User.currentUser, "title": deckName])
                } else {
                    // User is not enrolled in a school, handle the absence of data
                    print("not cool")
                    
                }
            }
        }
        
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        count += 1
        let indexPath = IndexPath(row: count - 1, section: 0)
        self.collectionView.insertItems(at: [indexPath])
    
    
    }
    
    func generateUniqueDeckID()->String{
        let uuid = UUID()
        return uuid.uuidString
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
