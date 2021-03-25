//
//  CoreDataManager.swift
//  SquatchNotes
//
//  Created by Hutson on 3/25/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "SquatchNotesDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store Failed \(error.localizedDescription)")
            }
            
        }
    }
    
    func saveNote(id: UUID, content: String, createdAt: Date, updatedAt: Date) {
        
        let note = Notes(context: persistentContainer.viewContext)
        note.content = content
        note.id = id
        note.createdAt = Date()
        note.updatedAt = Date()
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save note \(error)")
        }
    }
    
}
