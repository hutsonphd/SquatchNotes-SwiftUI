//
//  NotesViewModel.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

//import Foundation
//import FirebaseFirestore
//
//class NotesViewModel: ObservableObject {
//    @Published var notes = [Note] ()
//
//    private var db = Firestore.firestore()
//
//    func fetchData() {
//        db.collection("notes").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No document")
//                return
//            }
//            self.notes = documents.map { (queryDocumentSnapshot) -> Note in
//                let data = queryDocumentSnapshot.data()
//                let id = data["id"] as? String ?? ""
//                let name = data["name"] as? String ?? ""
//                let body = data["body"] as? String ?? ""
//                let description = data["description"] as? String ?? ""
//                let lastModified = data["lastModified"] as? String ?? ""
//                return Note(id: id, name: name, body: body, description: description, lastModified: lastModified)
//            }
//        }
//    }
//}
