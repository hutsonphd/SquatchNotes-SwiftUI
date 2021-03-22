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
    var body: String
    var createdAt: String
    var updatedAt: String
}

class NoteDataModel: ObservableObject {
    @Published var notes = [Note]()
  
    private var db = Firestore.firestore()
    private let user = Auth.auth().currentUser
  
  func fetchData() {
    if user != nil {
    db.collection("notes").whereField("owner", isEqualTo: user!.uid).addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }

        self.notes = documents.map { queryDocumentSnapshot -> Note in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let body = data["body"] as? String ?? ""
                let createdAt = data["createdAt"] as? String ?? ""
                let updatedAt = data["updatedAt"] as? String ?? ""

                return Note(id: id, body: body, createdAt: createdAt, updatedAt: updatedAt)

        }
    }
    }
  }
}
