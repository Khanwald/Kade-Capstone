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
                if let cell = collectionView.cellForItem(at: indexPath) {
                    UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        cell.alpha = 0.0
                    }, completion: nil)
                    cell.isHidden = true
                }
                
                if let cell = collectionView.cellForItem(at: indexPath1) {
                    UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        cell.alpha = 0.0
                    }, completion: nil)
                    cell.isHidden = true
                }
                
                checkGameCompletion(collectionView)
            }else{
                let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
                shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
                shakeAnimation.duration = 0.6
                shakeAnimation.values = [-10, 10, -8, 8, -6, 6, -4, 4, -2, 2, 0]

                if let cell = collectionView.cellForItem(at: indexPath) {
                    cell.layer.add(shakeAnimation, forKey: "shakeAnimation")
                }
                if let cell = collectionView.cellForItem(at: indexPath1) {
                    cell.layer.add(shakeAnimation, forKey: "shakeAnimation")
                }
                collectionView.cellForItem(at: indexPath)?.isHighlighted = false
                collectionView.cellForItem(at: indexPath1)?.isHighlighted = false
            }
                indexPath1 = []
                
        }
        
        
    }
    
    func checkGameCompletion(_ collectionView: UICollectionView) {
        let totalItems = collectionView.numberOfItems(inSection: 0)
        var isAllCellsHidden = true

        for item in 0..<totalItems {
            if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: 0)), !cell.isHidden {
                // At least one cell is still visible
                isAllCellsHidden = false
                break
            }
        }

        if isAllCellsHidden {
            performSegue(withIdentifier: "matchToOver", sender: nil)
            // Perform any actions or show a game completion message
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matchToOver" {
            if let destinationVC = segue.destination as? OverViewController {
                // Assign the string value to the destination view controller's property
                destinationVC.points = Deck.keys.count * 10
                destinationVC.gamemode = "match"
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
}
