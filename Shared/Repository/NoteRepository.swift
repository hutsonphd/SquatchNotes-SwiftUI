//
//  NoteRepository.swift
//  SquatchNotes
//
//  Created by Hutson on 3/27/21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class NoteRepository: ObservableObject {
    @Published var notes = [Note]()
  
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func loadData () {
        if user != nil {
        db.collection("notes")
            .whereField("userId", isEqualTo: user!.uid)
            .order(by: "updatedAt", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.notes = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Note.self)
                }
            }
            }
        }
    }

  func getNotes() {
    if user != nil {
    db.collection("notes")
        .whereField("userId", isEqualTo: user!.uid)
        .order(by: "updatedAt", descending: true)
        .addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }

        self.notes = documents.map { queryDocumentSnapshot -> Note in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let title = data["title"] as? String ?? ""
                let content = data["content"] as? String ?? ""
                let linkedNotes = data["linkedNotes"] as? [String] ?? [""]
                let userId = self.user!.uid
                let createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                let updatedAt = (data["updatedAt"] as? Timestamp)?.dateValue() ?? Date()

                return Note(
                    id: id,
                    title: title,
                    content: content,
                    linkedNotes: linkedNotes,
                    userId: userId,
                    createdAt: createdAt,
                    updatedAt: updatedAt
                )
                }
            }
        }
    }

    func addNote(_ note: Note) {
        do {
            var addedNote = note
            addedNote.userId = Auth.auth().currentUser!.uid
            let _ = try db.collection("notes").addDocument(from: addedNote)
        } catch {
            fatalError("Unable to endcode note: \(error.localizedDescription)")
        }

    }
    
    func updateNote(_ note: Note) {
        if let noteID = note.id {
            do {
            try db.collection("notes").document(noteID).setData(from: note)
            } catch {
                fatalError("unable to encode note: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteNoteList(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let note = notes[index]
            db.collection("notes").document(note.id!).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    self.loadData()
                }
            }
        }
    }
}
