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
    
    @IBOutlet weak var question: UILabel!
    
    struct Button{
        var button:UIButton
        var number:Int
    }
    var index = 0
    var word:String = Deck.keys[0]
    var definition:String = " "
    var buttons:[Button] = []
    var points = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        definition = Deck.terms[word]!
        question.text = word
        
        buttons = [Button(button: button1, number: 1), Button(button: button2, number: 2), Button(button: button3, number: 3), Button(button: button4, number: 4)]
        
        let answer = rando(min: 1, max: 4)
        
        check(x: answer)
        
    }
    
    func check(x:Int){
        for button in buttons {
            if button.number == x{
                button.button.setTitle(definition, for: .normal)
            }
        }
    }
    
    func rando(min:Int, max:Int)->Int{
        return Int.random(in: min...max)
    }
    
    @IBAction func next(_ sender: UIButton) {
        if sender.titleLabel?.text == definition{
            points += 1
        }
        nextQuestion()
        
    }
    
    func nextQuestion(){
        
        index += 1
        if index >= Deck.keys.count{
            return
        }
        word = Deck.keys[index]
        definition = Deck.terms[word]!
        
        question.text = word
        let answer = rando(min: 1, max: 4)
        check(x: answer)
        
        
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
