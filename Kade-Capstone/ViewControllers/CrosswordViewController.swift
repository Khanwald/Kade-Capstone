//
//  CrosswordViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 1/13/23.
//

import UIKit

class CrosswordViewController: UIViewController {
    
    @IBOutlet weak var grid: UICollectionView!
    
    @IBOutlet weak var hints: UILabel!
    
    var gridA:[[String]] = [[]]
    var best:Array<CrosswordsGenerator.Word> = Array()
    
    var max = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collection view init


        grid.dataSource = self
        grid.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 39, height: 39)


        // crossword init
        let crosswordsGenerator = CrosswordsGenerator()
        crosswordsGenerator.words = Deck.keys
        //Array(AccessViewController.deck.keys)
        crosswordsGenerator.columns = 10
        crosswordsGenerator.rows = 10
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
        best = bestResult
        print(bestResult)
        crosswordsGenerator.bestResult(terms: bestResult)
        gridA = crosswordsGenerator.toArray()
        print(gridA)
        
        hints.text = " "
        for word in bestResult{
            

            let x = getNumberHint(row: word.row - 1, col: word.column - 1)
            if let hint = Deck.terms[word.word]{
                hints.text! += "\(x). \(hint) "
            }
            
        }
        for array in gridA{
            for letter in array{
                if letter != "*"{
                    max += 1
                }
                    
            }
        }
        
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

    @IBAction func checkBoard(_ sender: Any) {
        if let visibleCells = grid.visibleCells as? [BlockCollectionViewCell] {
            
            visibleCells.forEach { cell in
                // do something with each cell
                
                let indexPath = grid.indexPath(for: cell)
                
                let row = indexPath?.section
                let col = indexPath?.item
    
                if cell.block.text == gridA[row!][col!]{
                        UIView.animate(withDuration: 0.5) {
                            cell.block.backgroundColor = .orange
                            cell.block.isUserInteractionEnabled = false
                        }
                    
                }else{
                    cell.block.backgroundColor = .red
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.03
                    animation.repeatCount = 4
                    animation.autoreverses = true
                    animation.fromValue = NSValue(cgPoint: CGPoint(x: cell.block.center.x - 5, y: cell.block.center.y))
                    animation.toValue = NSValue(cgPoint: CGPoint(x: cell.block.center.x + 5, y: cell.block.center.y))
                    cell.block.layer.add(animation, forKey: "position")
                    UIView.animate(withDuration: 0.5) {
                        cell.block.backgroundColor = .white
                        cell.block.text = ""
                    }
                }
                
                
            }
            var current = 0
            visibleCells.forEach{ cell in
                if cell.block.hasText{
                    current += 1
                }
                print(max)
                print(current)
            }
            
            if current == max{
                print("okdsf")
                performSegue(withIdentifier: "crossToOver", sender: nil)
            }
        }
            
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "crossToOver" {
            if let destinationVC = segue.destination as? OverViewController {
                // Assign the string value to the destination view controller's property
                destinationVC.points = max * 10
                destinationVC.gamemode = "crossword"
            }
        }
    }
    func getNumberHint(row:Int,col:Int)->Int{
        let size = best.count
        for count in 0...size - 1{
            let row2 = best[count].row
            let col2 = best[count].column
            
            if row == row2 - 1 && col == col2 - 1{
                return count + 1
            }
        }
        return 0
    }
}

extension CrosswordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "block", for: indexPath) as! BlockCollectionViewCell
        
        let row = indexPath.section
        let col = indexPath.item
        
//        print("\(row)  \(col)")
        if gridA[row][col] == "*"{
            cell.isHidden = true
            return cell
        }
        
        
//        cell.block.placeholder = gridA[row][col]
        let a = getNumberHint(row: row, col: col)
        
        if a != 0{
            cell.block.placeholder = String(a)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}

