//
//  GalleryViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 11.12.2020.
//

import UIKit

class OnlineGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage?] = []
    {
        didSet{
            self.collectionView.reloadItems(at: [IndexPath(row: images.count-1, section: 0)])
        }
    }
    let count = 30
    
    var elements: Int =  6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadImages()
    }
    
    func loadImages(){
        
        let queryApiKey = URLQueryItem(name: "key", value: "19345267-76e0d6d95fd22f444ddb6496c")
        let querySearch = URLQueryItem(name: "q", value: "fun+party")
        let queryType = URLQueryItem(name: "image_type", value: "photo")
        let queryCount = URLQueryItem(name: "per_page", value: "30")

        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = "/api/"
        components.queryItems = [queryApiKey, querySearch, queryType, queryCount]

        let urle = components.url
        print(urle)
        if let url = urle {
            
            let urlRequest = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, responce, error) in

                if let data = data {
                    
                    let jsonData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]

                    if let arr = jsonData["hits"] as? [[String: Any]] {
                        for picInfo in arr {
                            
                            if let imUrlStr = picInfo["webformatURL"] as? String {
                                
                                if let imUrl = URL(string: imUrlStr) {
                                    
                                    if let imData = try? Data(contentsOf: imUrl) {
                                        
                                        DispatchQueue.main.async {
                                            self.images.append(UIImage(data: imData))
                                        }
                                        
                                        
                                    }
                                }
                            }
                        }
 
                    }



                }
            }
            dataTask.resume()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! OnlineImageCollectionViewCell
        cell.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        if !(images.count <= indexPath.row) {
            cell.setImage(images[indexPath.row])
        } else {
            cell.animate()
            cell.imageView.image = nil
        }
        return cell
    }
    
}
