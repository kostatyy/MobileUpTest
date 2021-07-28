//
//  PhotoCoreDataManager.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit
import CoreData

//MARK: - Photos Core Data Manager
final class PhotosCoreDataManager {
    
    static var shared = PhotosCoreDataManager()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photos")
        container.loadPersistentStores { (_, error) in
            guard let error = error else {
               return
            }
            print(error.localizedDescription)
        }
        return container
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    //MARK: - Save Photo
    func savePhoto(photoItem: PhotoItem) -> Photo? {
        let newPhoto = Photo(context: moc)
        newPhoto.setValue(photoItem.url, forKey: "url")
        newPhoto.setValue(photoItem.date, forKey: "date")
        
        do {
            try self.moc.save()
            return newPhoto
        } catch {
            return nil
        }
        
    }
    
    //MARK: - Get All Photos
    func fetchPhotos() -> [Photo] {
        do {
            let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
            let photos = try moc.fetch(fetchRequest)
            return photos
        } catch {
            return []
        }
    }
    
}
