//
//  UserCustomizationViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 1/4/23.
//

import UIKit
class UserCustomizationViewController: UIViewController{
    
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func pressed4(_ sender: Any) {
        ImageDisplayed.backgroundImage = UIImage(named: "blackhole_wallpaper")
        
    }
    @IBAction func pressed1(_ sender: Any) {
        ImageDisplayed.backgroundImage = UIImage(named: "sea_woman_wallpaper")
        
    }
    
    @IBAction func pressed2(_ sender: Any) {
        ImageDisplayed.backgroundImage = UIImage(named: "baw_library_wallpaper")
        
    }
    
    @IBAction func pressed3(_ sender: Any) {
        ImageDisplayed.backgroundImage = UIImage(named: "flower_field_butterflies_wallpaper")
        
    }
}
    
