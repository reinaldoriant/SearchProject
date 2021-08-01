//
//  CoreDataManager.swift
//  SearchProject
//
//  Created by TI Digital on 01/08/21.
//

import Foundation
import CoreData

class CoreDataManager {
    // Using singleton
    
    var persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    //MARK: - Save data
    func save() {
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    //MARK: - get all data
    func getAll() -> [LocalSuggestion] {
        let request: NSFetchRequest<LocalSuggestion> = LocalSuggestion.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    //MARK: - Delete data
    func delete(name: LocalSuggestion){
        viewContext.delete(name)
        save()
    }
    
    func deleteAll(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LocalSuggestion")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    //MARK: - Initialize Core Data
    private init() {
        persistentContainer = NSPersistentContainer(name: "KompasAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize core data \(error)")
            }
        }
    }
}
