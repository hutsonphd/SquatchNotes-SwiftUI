//
//  SquatchNotesApp.swift
//  Shared
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI
import Firebase

@main
struct SquatchNotesApp: App {

    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
