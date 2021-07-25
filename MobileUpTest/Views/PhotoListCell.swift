//
//  PhotoListCell.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 25.07.2021.
//

import UIKit

class PhotoListCell: UICollectionViewCell {
    
    var photoImageView = UIImageView()
    var darkBg = UIView()
    var checkImage = UIImageView()
    
    static let reuseId = "PhotoListCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    override var isSelected: Bool {
        didSet {
            darkBg.alpha = isSelected ? 0.6 : 0
            checkImage.alpha = isSelected ? 1 : 0
        }
    }
    
    private func configure() {
        backgroundColor = .lightGray
        setupImage()
    }
    
    private func setupImage() {
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        darkBg.backgroundColor = .black
        darkBg.alpha = 0
        darkBg.translatesAutoresizingMaskIntoConstraints = false
        
        checkImage.image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        checkImage.alpha = 0
        checkImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(photoImageView)
        photoImageView.addSubview(darkBg)
        darkBg.addSubview(checkImage)
        
        photoImageView.pinToEdges()
        darkBg.pinToEdges()
        checkImage.pinToEdges(constant: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
