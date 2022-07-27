//
//  PredictionManager.swift
//  TRYAGAIN
//
//  Created by Nur Mutmainnah Rahim on 26/07/22.
//

import UIKit
import CoreML
import Vision

class PredictionManager {
    var emotionModel: MLModel
    var visionModel: VNCoreMLModel
    
    init() {
        self.emotionModel = FaceEmotionClassifier().model
        do{
            self.visionModel = try VNCoreMLModel(for: self.emotionModel)
        }catch{
            fatalError("Unable to create Vision Model...")
        }
    }
    
    func classification(for image: UIImage, complete: @escaping (String) -> Void){
        let request = VNCoreMLRequest(model: self.visionModel){(request,error) in
            guard error == nil else {complete("Error"); return} //If the model encapsulation doesn't work
            guard let results = request.results as? [VNClassificationObservation], let firstResult = results.first else{complete("No Results"); return} //If the result of conversion isn't saved or the image wasn't classified
            complete(String(format: "%@ %.1f%%", firstResult.identifier, firstResult.confidence * 100)) //Escaping Closure for giving string to write the classification and the confidence
        }
        request.imageCropAndScaleOption = .centerCrop //Considering only the center
        request.usesCPUOnly = true
        
        guard let ciImage = CIImage(image: image) else {complete("error creating image"); return}
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        
        //We use CIImage to optimize the image for our handler
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            do{
                try handler.perform([request]) //we will try with an handler to perform the request, if it works, the classification can be done.
            }catch{
                complete("Failed to perform classification.")
            }
        }
    }
}
                            
