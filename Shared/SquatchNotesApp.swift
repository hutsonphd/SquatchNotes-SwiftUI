//
//  SquatchNotesApp.swift
//  Shared
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI
import Firebase
import UIKit

@main
struct SquatchNotesApp: App {

    init () {
        FirebaseApp.configure()
        UITableView.appearance().backgroundColor = UIColor.squatchBackground
        UINavigationBar.appearance().backgroundColor = UIColor.squatchBackground
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.squatchText,
            .font : UIFont(name:"Cabin-Bold", size: 40)!
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.squatchText,
            .font : UIFont(name: "Cabin-Bold", size: 20)!
        ]
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
