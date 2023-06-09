//
//  CommentsViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 6/9/23.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentsCollectionView: UICollectionView!
    struct Comment {
        let user: String
        let comment: String
    }
    
    var comments: [Comment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsCollectionView.delegate = self
        commentsCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 130) // Set the desired width and height of the cells
        commentsCollectionView.collectionViewLayout = layout
        setUp()

        // Do any additional setup after loading the view.
    }

        // ...

    func setUp() {
        let ref = Database.database().reference().child("decks").child(AccessViewController.deckUser).child(AccessViewController.name).child("comments")

        ref.observeSingleEvent(of: .value) { [weak self] snapshot in

            for userSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                let user = userSnapshot.key
                print(snapshot)
                print(userSnapshot)
                print(user)
                
                for dataSnapshot in userSnapshot.children.allObjects as! [DataSnapshot]{
                    self?.comments.append(Comment(user: user, comment: dataSnapshot.value as! String))
                }


                self?.commentsCollectionView.reloadData()
            }
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comment", for: indexPath) as! DeckCollectionViewCell
        
        let comment = comments[indexPath.item]
        cell.deckNameLabel.text = comment.user
        cell.creatorLabel.text = comment.comment
        cell.creatorLabel.numberOfLines = 0
        
        return cell
    }
}

