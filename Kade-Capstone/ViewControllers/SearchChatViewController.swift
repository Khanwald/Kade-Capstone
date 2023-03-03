//
//  SearchChatViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 2/27/23.
//

import UIKit

class SearchChatViewController: UIViewController {

    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var response: UILabel!
    
    var models:[String] = []
    var text:String = ""
    override func viewDidLoad() {
        APICaller.shared.setup()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submit(_ sender: Any) {
        response.text! = ""
        text = question.text ?? " "
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else{return}
        
        models.append("\(ViewController.User.currentUser): \(text)")
        APICaller.shared.getResponse(input: text){ response in
            switch response{
            case .success(let output):
                print(output)
                DispatchQueue.main.async {
                    self.models.append("KADE: \(output)")
                    self.question.text = ""
                }
            case .failure:
                print("Failure")
            }
            
        }
        print(models)
        for model in models{
            response.text! += "\(model) \n"
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
