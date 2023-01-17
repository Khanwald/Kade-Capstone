//
//  CrosswordViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 1/13/23.
//

import UIKit

class CrosswordViewController: UIViewController {
    
    @IBOutlet weak var grid: UICollectionView!
    var gridA:[[String]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collection view init
        grid.delegate = self
        grid.dataSource = self
        let layout = grid.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let size = min(grid.frame.size.width, grid.frame.size.height)/10
        layout.itemSize = CGSize(width: size, height: size)


        // crossword init
        let crosswordsGenerator = CrosswordsGenerator()
        crosswordsGenerator.words = ["Cell", "Genes", "Solar", "Laser", "Virus", "Comet", "Wires", "Atoms", "Algae", "Orbit", "Biome", "Fungi", "Laser", "Neuron", "Tissue", "Proton", "Virus", "Algae", "Quarks", "Bacteria", "Fungus", "Virus", "Genome", "Laser", "Galaxy", "Cells", "Solar", "Probes", "Cytron", "Neuron", "Comets"]
        //Array(AccessViewController.deck.keys)
        crosswordsGenerator.columns = 9
        crosswordsGenerator.rows = 9
        crosswordsGenerator.debug = true
        crosswordsGenerator.emptySymbol = "*"
        
        var bestResult: Array<CrosswordsGenerator.Word> = Array()
        let startTime = NSDate()
        let timeInterval: TimeInterval = 3
        
        while (fabs(startTime.timeIntervalSinceNow) < timeInterval) {
            crosswordsGenerator.generate()
            let result = crosswordsGenerator.result
        
            if result.count > bestResult.count {
                bestResult.removeAll()
                for word in result {
                    bestResult.append(word)
                }
            }
        }
        
        print(bestResult)
        crosswordsGenerator.bestResult(terms: bestResult)
        gridA = crosswordsGenerator.toArray()
//        for row in 0...gridA.count - 1{
//            for col in 0...gridA[row].count - 1{
//                let randomLetter = String(Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").shuffled().prefix(1))
//                switch gridA[row][col]{
//                case "*":
//                    gridA[row][col] = randomLetter
//                default:
//                    continue
//                }
//
//            }
//        }
        print(gridA)
        
    }
    
    func longestWord(words:[String])-> Int{
        var long = 0
        for item in words{
            if item.count > long{
                long = item.count
            }
        }
        return long
    }

}
extension CrosswordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "block", for: indexPath) as! BlockCollectionViewCell
        
        let row = indexPath.section
        let col = indexPath.item

        
//        print("\(row)  \(col)")
//        if gridA[row][col] == "*"{
//            cell.textField.backgroundColor = .black
//            cell.isHidden = true
//        }
        cell.label.text = gridA[row][col]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

