//
//  TestViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 2/15/23.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var question: UILabel!
    
    struct Button{
        var button:UIButton
        var number:Int
    }
    
    var index = 0
    var word:String = Deck.keys[0]
    var definition:String = " "
    var buttons:[Button] = []
    var pointsNum = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.titleLabel?.adjustsFontSizeToFitWidth = true
        button1.titleLabel?.minimumScaleFactor = 0.2

        button2.titleLabel?.adjustsFontSizeToFitWidth = true
        button2.titleLabel?.minimumScaleFactor = 0.2
        
        button3.titleLabel?.adjustsFontSizeToFitWidth = true
        button3.titleLabel?.minimumScaleFactor = 0.2
        
        button4.titleLabel?.adjustsFontSizeToFitWidth = true
        button4.titleLabel?.minimumScaleFactor = 0.2
        // Do any additional setup after loading the view.
        definition = Deck.terms[word]!
        question.text = word
        
        buttons = [Button(button: button1, number: 1), Button(button: button2, number: 2), Button(button: button3, number: 3), Button(button: button4, number: 4)]
        
        let answer = rando(min: 1, max: 4)
        
        let indexes = uniqueArrays(array: [answer, rando(min: 1, max: 4),rando(min: 1, max: 4),rando(min: 1, max: 4)], min: 1, max: 4, size: 4)
        
        let options = otherOptions()

        for i in 0...3{
            check(x: indexes[i], def: options[i])
        }
        points.text = String(pointsNum)
        
    }
    
    func check(x:Int, def:String){
        for button in buttons {
            if button.number == x{
                button.button.setTitle(def, for: .normal)
            }
        }
    }
    
    func rando(min:Int, max:Int)->Int{
        return Int.random(in: min...max)
    }
    
    @IBAction func next(_ sender: UIButton) {
        if sender.titleLabel?.text == definition{
            pointsNum += 1
            UIView.transition(with: sender, duration: 0.6, options: .transitionFlipFromRight, animations: {
                        sender.setTitle("", for: .normal)
                    }, completion: nil)
        }
        else{
            let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            shakeAnimation.duration = 0.6
            shakeAnimation.values = [-10, 10, -8, 8, -6, 6, -4, 4, -2, 2, 0]

            sender.layer.add(shakeAnimation, forKey: "shakeAnimation")
        }
        points.text = String(pointsNum)
        nextQuestion()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "testToOver" {
            if let destinationVC = segue.destination as? OverViewController {
                // Assign the string value to the destination view controller's property
                destinationVC.points = pointsNum * 15
                destinationVC.gamemode = "test"
            }
        }
    }
    
    func nextQuestion(){
        
        index += 1
        if index >= Deck.keys.count{
            performSegue(withIdentifier: "testToOver", sender: nil)
            return
        }
        
        word = Deck.keys[index]
        definition = Deck.terms[word]!
        
        question.text = word
        let answer = rando(min: 1, max: 4)
        
        let indexes = uniqueArrays(array: [answer, rando(min: 1, max: 4),rando(min: 1, max: 4),rando(min: 1, max: 4)], min: 1, max: 4, size: 4)
        
        let options = otherOptions()
        print(answer)
        print(options)
        print(indexes)
        for i in 0...3{
            check(x: indexes[i], def: options[i])
        }
         
        
    }
    
    func uniqueArrays(array:[Int], min:Int, max:Int, size:Int)->[Int]{
        var uniqueIndexes = Set(array)
        
        while uniqueIndexes.count < size{
            uniqueIndexes.insert(rando(min: min, max: max))
        }
        
        return Array(uniqueIndexes)
    }
    
    func otherOptions()->[String]{
        
        var a = rando(min: 0, max: Deck.keys.count - 1)
        var b = rando(min: 0, max: Deck.keys.count - 1)
        var c = rando(min: 0, max: Deck.keys.count - 1)
        
        
        let finalIndexes = uniqueArrays(array: [index,a,b,c], min: 0, max: Deck.keys.count - 1, size: 4)
        
        return [Deck.terms[Deck.keys[finalIndexes[0]]]!, Deck.terms[Deck.keys[finalIndexes[1]]]!,Deck.terms[Deck.keys[finalIndexes[2]]]!, Deck.terms[Deck.keys[finalIndexes[3]]]!]
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
