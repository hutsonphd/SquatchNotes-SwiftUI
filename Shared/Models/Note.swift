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
    @DocumentID var id: String?
    var title: String
    var content: String
    var linkedNotes: [String]
    var userId: String?
    var createdAt: Date
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY h:mm a"
        return formatter.string(from: createdAt)
    }
    var updatedAt: Date
    var updatedAtString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY h:mm a"
        return formatter.string(from: updatedAt)
    }
}

extension Note: Equatable, Hashable {}

#if DEBUG
let testDataNotes = [
Note(title: "Test Note 1", content: "Test Note Content 1", linkedNotes: [""], userId: "3P42hhinn6U997hn5lBxgUqHFcF2", createdAt: Date(), updatedAt: Date()),
Note(title: "Test Note 2", content: "Test Note Content 2", linkedNotes: [""], userId: "3P42hhinn6U997hn5lBxgUqHFcF2", createdAt: Date()-1, updatedAt: Date()-1)
]
#endif
