//
//  OverViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 6/7/23.
//

import UIKit

class OverViewController: UIViewController {

    var points:Int?
    var gamemode:String?
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let points = points{
            pointsLabel.text = String(points)
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeButton(_ sender: Any) {
    }
    
    @IBAction func restartButton(_ sender: Any) {
        if let gamemode = gamemode{
            if gamemode == "match"{
                performSegue(withIdentifier: "retryMatch", sender: nil)
            }
            if gamemode == "test"{
                performSegue(withIdentifier: "rewindTest", sender: nil)
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
