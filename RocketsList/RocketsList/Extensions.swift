//
//  Extensions.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 14.09.2021.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(cellType: Cell.Type, nib: Bool = true) {
        let reuseIdentifier = String(describing: cellType)
        
        if nib {
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueCell<Cell: UICollectionViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? Cell
    }
}

extension UIImageView {
    public func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    public func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
