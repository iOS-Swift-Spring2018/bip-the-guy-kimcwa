//
//  ViewController.swift
//  Bip The Guy
//
//  Created by Bryan Kim on 2/8/18.
//  Copyright © 2018 Bryan Kim. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    


    @IBOutlet weak var imageToPunch: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("imageView.frame = \(imageView.frame)")
        
    }

    
    
    // MARK: Functions
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        let shrinkValue: CGFloat = 60
        
        // shrink our imageToPunch by 60 pixels
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + shrinkValue, y: self.imageToPunch.bounds.origin.y + shrinkValue, width: self.imageToPunch.bounds.size.width - shrinkValue, height: self.imageToPunch.bounds.size.height - shrinkValue)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.imageToPunch.bounds = bounds }, completion: nil)
        
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        //Can we load in the file soundName?
        if let sound = NSDataAsset(name: soundName) {
            // check if sound.data is a sound file
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if sound.data is not a valid audio file
                print("ERROR: data in \(soundName) could not be played as a sound.")
            }
        } else {
            // if reading in the NSDataAsset did not work, tell the user / report the error
            print("ERROR: file\(soundName) did not load")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageToPunch.image = selectedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    

    
    @IBAction func photoLibraryButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            showAlert(title: "Camera Is Not Available" , message: "There is no camera available on this device")
            
        }
        
    }
    
    
    @IBAction func imagePressed(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
    
    
    
    
    
//    @IBAction func up200ButtonPressed(_ sender: UIButton) {
//        UIView.animate(withDuration: 1.0, animations: { self.imageToPunch.frame.origin.y -= 200 })
//    }
//
//
//    @IBAction func increaseBy60ButtonPressed(_ sender: UIButton) {
//        let largerRect = CGRect(x: imageToPunch.bounds.origin.x - 60, y: imageToPunch.bounds.origin.y - 60, width: imageToPunch.bounds.width + 60, height: imageToPunch.bounds.height + 60)
//
////        UIView.animate(withDuration: 1.0, animations: {self.imageView.bounds = largerRect})
//
//        // Animation with Bounce
//        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, animations: {self.imageToPunch.bounds = largerRect})
//
//    }
//    
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

