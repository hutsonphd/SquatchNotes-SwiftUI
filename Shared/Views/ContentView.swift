//
//  ContentView.swift
//  Shared
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @ObservedObject var sessionStore = SessionStore()
    @ObservedObject var notes = NotesViewModel()
    
    init() {
        sessionStore.listen()
        notes.getNotes()
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes.notes) { note in
                    NavigationLink(destination: NoteEditor(note: note), label: {
                        NoteRow(note: note)
                    })
                    .listRowBackground(Color("Background"))
                }
                .onAppear(perform: notes.getNotes)
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing: AddNoteButton().padding())
        }
        .fullScreenCover(isPresented: $sessionStore.isAnon, content: {
            Login()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
