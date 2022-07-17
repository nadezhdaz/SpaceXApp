//
//  ImageLoader.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 14.09.2021.
//

import UIKit

class ImageLoader: UIImageView {
    
    // MARK: - Initializers
    
    // MARK: - Properties
    
    public var imageCache = NSCache<AnyObject, AnyObject>()
    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCache = NSCache<AnyObject, AnyObject>()
        imageCache.countLimit = 100  // number of objects
        imageCache.totalCostLimit = 200 * 1024 * 1024  // max 200MB used
    }
    
    
    
    // MARK: - Public Methods

    
    public func loadImageWithUrl(_ url: URL) { //}, mode: UIIViewContentMode = .scaleAspectFit) {
    
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url
        image = nil
    
        activityIndicator.startAnimating()
    
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            
            activityIndicator.stopAnimating()
            return
        }
    
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
    
            if let error = error {
            
                print(error)
            
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
            
                return
            }
    
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
            
                    self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
            
                }
            
                self.activityIndicator.stopAnimating()
        
            })
    
        }).resume()

    }
    
    public func setInsets(_ insets: UIEdgeInsets) {
        self.image = self.image?.withInset(insets)
    }
    
    public func setRectInsets(_ insets: UIEdgeInsets) {
        self.image = self.image?.withAlignmentRectInsets(insets)
    }
    
    public func roundTopCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}

extension UIImage {

    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)

        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }

        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)

        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
}
