//
//  ViewController.swift
//  TRYAGAIN
//
//  Created by Nur Mutmainnah Rahim on 26/07/22.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    var predictionManager = PredictionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(didTapOnImage(tapGesture:)))
        imageView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    

    @objc func didTapOnImage(tapGesture: UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }


}

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            dismiss(animated: true, completion: nil)
            return
        }
        dismiss(animated: true, completion: nil)
        
        imageView.image = image
        let monoImage = image.mono
        
        predictionManager.classification(for: monoImage){(result) in
            DispatchQueue.main.async {
                [weak self] in
                self?.predictionLabel.text = result
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func classifyImage(for image: UIImage){
        
    }
}

