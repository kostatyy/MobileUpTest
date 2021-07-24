//
//  PhotoCoreDataManager.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit
import CoreData

/* Photos Core Data Manager */
final class PhotosCoreDataManager {
    
    static var shared = PhotosCoreDataManager()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photos")
        container.loadPersistentStores { (_, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
        return container
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // Save Photo
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
    
    // Get Photo
    func getPhoto(id: NSManagedObjectID) -> Photo? {
        do {
            return try moc.existingObject(with: id) as? Photo
        } catch {
            return nil
        }
    }
    
    // Get All Photos
    func fetchPhotos() -> [Photo] {
        do {
            let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
            let photos = try moc.fetch(fetchRequest)
            return photos
        } catch {
            return []
        }
    }
    
    // Delete All Photos
    func deletePhotos() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
            let request: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try moc.execute(request)
            try moc.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
