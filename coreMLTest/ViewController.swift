//
//  ViewController.swift
//  coreMLTest
//
//  Created by Abdul Diallo on 2/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let usrImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageDisplay.image = usrImg
        }
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func camBtn(_ sender: UIBarButtonItem) {
        present(picker, animated: false, completion: nil)
    }
    
    
    
}

