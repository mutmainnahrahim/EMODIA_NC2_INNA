//
//  Class.swift
//  TRYAGAIN
//
//  Created by Nur Mutmainnah Rahim on 26/07/22.
//


import UIKit

extension UIImage{
    var mono: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectMono")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        return processedImage
    }
}
