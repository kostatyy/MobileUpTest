//
//  GalleryViewController.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    private var viewModel = GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mobile Up Gallery"
        navigationController?.navigationBar.isHidden = false
        customizeNavBarController()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logoutButtonTapped))
        
        DispatchQueue.main.async {
            self.viewModel.getPhotos {
                DispatchQueue.main.async {
                    self.setupCollectionView()
                }
            }
        }
        
    }
    
    // Setting Up Gallery Collection View
    private func setupCollectionView() {
        galleryCollectionView.collectionViewLayout = createCompostionalLayout()
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        galleryCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseId)
    }
    
    // Logout from VK
    @objc private func logoutButtonTapped() {
        let loginVC: LoginViewController = .instantiate()
        viewModel.logoutFromVK {
            self.navigationController?.pushViewController(loginVC, animated: false)
        }
    }
    
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.reuseId, for: indexPath) as! GalleryCell
        cell.galleryImageView.loadUserImage(urlString: viewModel.photos[indexPath.row].url!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC: PhotoViewController = .instantiate()
        let photoViewModel = PhotoViewModel()
        photoViewModel.photos = viewModel.photos
        photoVC.photo = viewModel.photos[indexPath.row]
        photoVC.viewModel = photoViewModel
        navigationController?.pushViewController(photoVC, animated: true)
    }
    
    // Custom Layout
    private func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        return layout
    }
}
