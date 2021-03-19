//
//  NotesViewModel.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import Foundation
import Firebase

struct NoteData: Codable, Identifiable {
    var id: String
    var name: String
    var body: String
    var description: String
    var lastModified: String
}


class NotesViewModel: ObservableObject {
    
    @Published var notes = [NoteData]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func fetchData() {
        if (user != nil) {
            db.collection("notes").whereField("owner", isEqualTo: user!.uid).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print ("no docs returned!")
                    return
                }
                self.notes = documents.map({docSnapshot -> NoteData in
                    let data = docSnapshot.data()
                    let noteId = docSnapshot.documentID
                    let name = data["name"] as? String ?? ""
                    let body = data["body"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let lastModified = data["lastModified"] as? String ?? ""
                    return NoteData(id: noteId, name: name, body: body, description: description, lastModified: lastModified)
                })
            })
        }
    }
    
    func createNote(name: String, handler: @escaping () -> Void) {
        if (user != nil) {
            db.collection("notes").addDocument(data: [
                                                "name": name,
                                                "body": "",
                                                "description": "",
                                                "lastModified": Date(),
                                                "owner": user!.uid]) { err in
                if let err = err {
                    print("error adding document! \(err)")
                } else {
                    handler()
                }
            }
        }
    }
}
