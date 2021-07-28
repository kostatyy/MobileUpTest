//
//  PhotoViewController.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addedPhotoImageView: UIImageView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photo: Photo?
    var viewModel: PhotoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateString = photo?.date.convertUnixToTime()
        title = dateString ?? "NaN"
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(openShareMenu))
        customizeNavBarController()
        
        setupPhotoImageView()
        setupPhotosCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for (index, item) in viewModel.photos.enumerated() {
            if item == photo {
                photosCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: [])
            }
        }
        
    }
    
    private func setupPhotoImageView() {
        photoImageView.loadUserImage(urlString: (photo?.url)!)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.enableZoom()
        
        addedPhotoImageView.image = UIImage(systemName: "checkmark.circle.fill")
    }
    
    private func setupPhotosCollectionView() {
        photosCollectionView.collectionViewLayout = createCompostionalLayout()
        photosCollectionView.alwaysBounceVertical = false
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.register(PhotoListCell.self, forCellWithReuseIdentifier: PhotoListCell.reuseId)
    }
    
    //MARK: - Open Menu For Image To Save Or Share It
    @objc private func openShareMenu() {
        let activityController = UIActivityViewController(activityItems: [photoImageView.image ?? UIImage(named: "image")!], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
            self.addedPhotoImageView.alpha = 0.8
            UIView.animate(withDuration: 0.2) {
                self.addedPhotoImageView.transform = .init(scaleX: 0.6, y: 0.6)
            } completion: { finished in
                UIView.animate(withDuration: 0.2) {
                    self.addedPhotoImageView.transform = .init(scaleX: 1, y: 1)
                } completion: { (_) in
                    UIView.animate(withDuration: 0.2, delay: 1) {
                        self.addedPhotoImageView.alpha = 0
                    }
                }

            }
        }
        present(activityController, animated: true)
    }
}

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCell.reuseId, for: indexPath) as! PhotoListCell
        cell.photoImageView.loadUserImage(urlString: viewModel.photos[indexPath.row].url!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? PhotoListCell else {return}
        
        selectedCell.isSelected = true
        
        let selectedPhoto = viewModel.photos[indexPath.row]
        photoImageView.loadUserImage(urlString: selectedPhoto.url!)
    }
    
    //MARK: - Custom Layout
    private func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6.5),
                                                   heightDimension: .fractionalWidth(1/6.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 2)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        
        return layout
    }
}
