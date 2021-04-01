//
//  User.swift
//  SquatchNotes (iOS)
//
//  Created by Hutson on 3/26/21.
//

import Foundation

struct User {
    var uid: String
    var email: String?
    var name: String?
    var photo: String?
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
