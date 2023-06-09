//
//  SchoolViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 6/8/23.
//

import UIKit
import Firebase
class SchoolViewController: UIViewController {
    
    var school:String?
    
    @IBOutlet weak var submitButton: UIButton!
    var sharedDecks:[Person] = []
    
    @IBOutlet weak var schoolCodeField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var schoolDeckCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolDeckCollectionView.dataSource = self
        schoolDeckCollectionView.delegate = self
        
        fetchSchool { [weak self] (school) in
            if let school = school {
                // User is enrolled in a school, handle the data
                self?.showEnrolledSchool(school)
            } else {
                // User is not enrolled in a school, handle the absence of data
                self?.showNoSchoolEnrollment()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func showEnrolledSchool(_ school: String) {
        // Update UI or perform actions for enrolled school
        schoolCodeField.isHidden = true
        welcomeLabel.isEnabled = true
        var ref: DatabaseReference
        ref = Database.database().reference(withPath: "schools")
        
        // Obtains the school code if there is one
        ref.child(school).child("name").observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? String {
                self.welcomeLabel.text = data
            } else {
                print("No school")
            
            }
        }
        
        fetchDeckPairings(forSchoolCode: school)
        schoolDeckCollectionView.isHidden = false
        submitButton.isHidden = true
    }
    
    func showNoSchoolEnrollment() {
        // Update UI or perform actions for no school enrollment
        welcomeLabel.text = "Welcome \(ViewController.User.currentUser)! Join a class now!"
        schoolDeckCollectionView.isHidden = true
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
    
    @IBAction func submitButton(_ sender: Any) {
        let ref = Database.database().reference(withPath: "users/\(ViewController.User.currentUser)")
        guard let code = schoolCodeField.text else {return}

        let valuesToUpdate = ["schoolCode": code]

        ref.updateChildValues(valuesToUpdate) { (error, ref) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("School code updated in the database")
            }
        }
        
        fetchSchool { [weak self] (school) in
            if let school = school {
                // User is enrolled in a school, handle the data
                self?.showEnrolledSchool(school)
            } else {
                // User is not enrolled in a school, handle the absence of data
                self?.showNoSchoolEnrollment()
            }
        }

        
    }
    
    func fetchDeckPairings(forSchoolCode schoolCode: String) {
            let ref = Database.database().reference(withPath: "schools/\(schoolCode)/decks")
            
            ref.observe(.value) { [weak self] (snapshot) in
                guard let deckData = snapshot.value as? [String: [String: String]] else {
                    print("No decks found")
                    return
                }
                
                self?.sharedDecks = []
                
                for (deckID, deckInfo) in deckData {
                    if let creator = deckInfo["creator"], let title = deckInfo["title"] {
                        self?.sharedDecks.append(Person(creator: creator, title: title))
                        print("Deck ID: \(deckID), Creator: \(creator), Title: \(title)")
                    }
                }
                
                self?.schoolDeckCollectionView.reloadData()
            }
        }



    
    
}
extension SchoolViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sharedDecks.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = schoolDeckCollectionView.dequeueReusableCell(withReuseIdentifier: "set", for: indexPath) as! DeckCollectionViewCell
        cell.deckNameLabel.text = sharedDecks[indexPath.item].title
        cell.creatorLabel.text = sharedDecks[indexPath.item].creator
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = schoolDeckCollectionView.cellForItem(at: indexPath) as! DeckCollectionViewCell
        AccessViewController.name = cell.deckNameLabel.text ?? " "
        AccessViewController.deckUser = cell.creatorLabel.text ?? " "
        performSegue(withIdentifier: "schoolToDeck", sender: nil)
        
    }
        
        
}

struct Person{
    var creator:String
    var title:String
}
