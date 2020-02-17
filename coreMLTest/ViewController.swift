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
    
    private let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let usrImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageDisplay.image = usrImg
            guard let mlImage = CIImage(image: usrImg) else {
                fatalError("Conversion into CIImage failed.")
            }
            detect(image: mlImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Failed loading CoreML...")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Enable to process the request")
            }
            if let found = results.first {
                self.navigationItem.title = found.identifier
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print("Failed to handle the request - \(error)")
        }
        
    }

    @IBAction func camBtn(_ sender: UIBarButtonItem) {
        
        present(picker, animated: false, completion: nil)
        
    }
    
    
    
}

