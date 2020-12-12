//
//  ImageCollectionViewCell.swift
//  My great app
//
//  Created by Oleksii Afonin on 11.12.2020.
//

import UIKit

class OnlineImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func animate() {
        for case let sub as UIActivityIndicatorView in contentView.subviews {
            sub.startAnimating()
        }
    }
    func setImage(_ image: UIImage?) {
        
        for case let sub as UIActivityIndicatorView in contentView.subviews {
            sub.stopAnimating()
        }
        self.imageView.image = image
    }
}
