//
//  MatchVIewController.swift
//  Kade-Capstone
//
//  Created by 11k on 1/24/23.
//

import UIKit

class MatchViewController: UIViewController{
    var indexPath1:IndexPath = []
    var array:[String] = []
    @IBOutlet weak var matchBoard: UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        matchBoard.dataSource = self
        matchBoard.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 195, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        matchBoard.collectionViewLayout = layout
        
        array = Deck.combined
    }
    
}

extension MatchViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = matchBoard.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! MatchCollectionViewCell
        
        cell.text.text = array[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath1.isEmpty{
            indexPath1 = indexPath
            collectionView.cellForItem(at: indexPath)?.isHighlighted = true
        }
        else if indexPath == indexPath1{
            return
        }
        else if !indexPath1.isEmpty{
            
            collectionView.cellForItem(at: indexPath)?.isHighlighted = true
            
            let game = MatchGame(indexPath1: indexPath, indexPath2: indexPath1, array: array)
            
            if game.match(){
                print("OK")
                collectionView.cellForItem(at: indexPath)?.isHidden = true
                collectionView.cellForItem(at: indexPath1)?.isHidden = true
            }
            else{
                collectionView.cellForItem(at: indexPath)?.isHighlighted = false
                collectionView.cellForItem(at: indexPath1)?.isHighlighted = false
            }
            indexPath1 = []
            
        }
    }
    
    

}

struct MatchGame{
    var indexPath1:IndexPath
    var indexPath2:IndexPath
    
    var array:[String]
    
    func sameIndex()->Bool{
        return indexPath1 == indexPath2
    }
    
    func match()->Bool{
        let word1 = array[indexPath1.item]
        let word2 = array[indexPath2.item]
        
        if let a = Deck.terms[word1]{
            print(a)
            if a == word2{
                return true
            }
        }
        
        if let a = Deck.terms[word2]{
            print(a)
            if a == word1{
                return true
            }
        }
        
        
        return false
    }
    
}
