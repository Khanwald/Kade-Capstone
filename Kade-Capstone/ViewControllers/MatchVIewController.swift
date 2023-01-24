//
//  MatchVIewController.swift
//  Kade-Capstone
//
//  Created by 11k on 1/24/23.
//

import UIKit

class MatchViewController: UIViewController{
    
    @IBOutlet weak var matchBoard: UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        matchBoard.dataSource = self
        matchBoard.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let width = matchBoard.widthAnchor.hashValue
        layout.itemSize = CGSize(width: 195, height: 50)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        matchBoard.collectionViewLayout = layout
        
    }
    
}

extension MatchViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = matchBoard.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! MatchCollectionViewCell
        
        return cell
    }
    
    

}
