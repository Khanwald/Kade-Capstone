//
//  NotesViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 3/9/23.
//

import UIKit

class NotesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImage: UIImageView!
    
    @IBOutlet weak var commentSection: UITextView!
    
    @IBOutlet weak var isAnon: UISwitch!
    
    var sender = ViewController.User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Adds tap gesture to the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGesture.numberOfTapsRequired = 1
        selectedImage.isUserInteractionEnabled = true
        selectedImage.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func anonMode(_ sender: Any) {
        if isAnon.isOn == true{
            self.sender = "Anon"
        }
        else{
            self.sender = ViewController.User.currentUser
        }
    }
    // Submit comment and image w/ users name
    @IBAction func sendNote(_ sender: Any) {
        print(self.sender)
    }
    @IBAction func addImage(_ sender: Any) {
        
    }
    // Opens photo library when image view is tapped
    @objc func imageTapped() {
        didTap()
    }
    // Func to open photo library
    func didTap(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        
        if let sheet = picker.presentationController as? UISheetPresentationController{
            sheet.detents = [.medium(),.large()]
            sheet.selectedDetentIdentifier = .large
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let sheet = picker.presentationController as? UISheetPresentationController{
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .medium
            }
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage.image = image
        
        }
        
    }

}
