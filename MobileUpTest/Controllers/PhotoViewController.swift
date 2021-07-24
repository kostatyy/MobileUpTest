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
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateString = photo?.date.convertUnixToTime()
        title = dateString ?? "NaN"
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(openShareMenu))
        customizeNavBarController()
        
        setupPhotoImageView()
    }
    
    private func setupPhotoImageView() {
        photoImageView.loadUserImage(urlString: (photo?.url)!)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        
        addedPhotoImageView.image = UIImage(systemName: "checkmark.circle.fill")
    }
    
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
