//
//  GalleryViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 05.12.2020.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imagePicker: UIImagePickerController!
    var images: [UIImage] = []
    {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var elements: Int =  6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer {
            dismiss(animated: true)
        }
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.images.append(image)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
}
