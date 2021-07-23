//
//  GalleryCell.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    var galleryImageView = UIImageView()
    
    static let reuseId = "GalleryCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        backgroundColor = .lightGray
        setupImage()
    }
    
    private func setupImage() {
        galleryImageView.clipsToBounds = true
        galleryImageView.contentMode = .scaleAspectFill
        galleryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(galleryImageView)
        
        galleryImageView.pinToEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
