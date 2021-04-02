//
//  SquatchNotesApp.swift
//  Shared
//
//  Created by Hutson on 3/18/21.
//

#if os(macOS)
import SwiftUI
import Firebase
#else
import SwiftUI
import Firebase
import UIKit
#endif

@main
struct SquatchNotesApp: App {

    init () {
        FirebaseApp.configure()
        UITableView.appearance().backgroundColor = UIColor.squatchBackground
        let standard = UINavigationBarAppearance()
        standard.configureWithTransparentBackground()
        standard.backgroundColor = UIColor.squatchBackground
        standard.titleTextAttributes = [.foregroundColor: UIColor.squatchText, .font : UIFont(name: "Cabin-Bold", size: 20)!]
        standard.largeTitleTextAttributes = [.foregroundColor: UIColor.squatchText, .font : UIFont(name:"Cabin-Bold", size: 40)!]
        
        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [.foregroundColor: UIColor.squatchText, .font : UIFont(name: "Cabin-Regular", size: 20)!]
        standard.buttonAppearance = button
        
        let done = UIBarButtonItemAppearance(style: .done)
        done.normal.titleTextAttributes = [.foregroundColor: UIColor.squatchText, .font : UIFont(name: "Cabin-Regular", size: 20)!]
        standard.doneButtonAppearance = done
        
        
        UINavigationBar.appearance().standardAppearance = standard
        UINavigationBar.appearance().scrollEdgeAppearance = standard
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
