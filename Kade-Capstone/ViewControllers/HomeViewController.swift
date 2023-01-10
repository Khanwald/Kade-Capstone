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
    
    @IBOutlet weak var xpBar: UIProgressView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var deckCollectionView: UICollectionView!
    
    var array = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImage.image = ImageDisplayed.backgroundImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        backgroundImage.image = ImageDisplayed.backgroundImage
        xpBar.transform = CGAffineTransform(scaleX: 1, y: 2)
        



        let layout1 = deckCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout1.scrollDirection = .horizontal
        deckCollectionView.delegate = self
        deckCollectionView.dataSource = self
        
        
        let imageView = UIImageView(image: UIImage(named: "fish_background"))
        deckCollectionView.backgroundView = imageView

        observe()

    
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch {
          print("Error signing out: \(error)")
        }

        
    }
    
    @IBAction func goBack(segue:UIStoryboardSegue){
        
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
        let cell = deckCollectionView.cellForItem(at: indexPath) as! DeckCollectionViewCell
        AccessViewController.name = cell.deckNameLabel.text ?? " "
        
        performSegue(withIdentifier: "terms", sender: nil)
        

    }
    
}
