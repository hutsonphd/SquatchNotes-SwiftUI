//
//  Book.swift
//  SquatchNotes
//
//  Created by Hutson on 3/21/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable { 
    var id: String
    var title: String
    var content: String
    var linkedNotes: [String]
    var userId: String
    var createdAt: Date
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.string(from: createdAt)
    }
    var updatedAt: Date
    var updatedAtString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter.string(from: updatedAt)
    }
}

extension Note: Equatable, Hashable {}

class NotesViewModel: ObservableObject {
    @Published var notes = [Note]()
  
    private var db = Firestore.firestore()
    private let user = Auth.auth().currentUser
  
  func getNotes() {
    if user != nil {
    db.collection("notes").whereField("userId", isEqualTo: user!.uid).addSnapshotListener { (querySnapshot, error) in
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
    
    func addNote() {
        if user != nil {
            db.collection("notes").addDocument(data: [
                "title": "New Note",
                "content": "",
                "linkedNotes": [""],
                "createdAt": Date(),
                "updatedAt": Date(),
                "userId": self.user!.uid
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func updateNote(id: String, title: String, content: String) {
        if user != nil {
            db.collection("notes").document(id).updateData([
                "title" : title,
                "content" : content,
                "updatedAt" : Date()
            ]) {
                err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
}
