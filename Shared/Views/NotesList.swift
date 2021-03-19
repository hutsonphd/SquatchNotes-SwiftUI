//
//  NotesList.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI

struct NotesList: View {
    
    @ObservedObject var viewModel = NotesViewModel()
    @State var newNoteModal = false
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.notes) { note in
                NavigationLink(destination: NotesEditor(note: note)) {
                    HStack {
                        VStack (alignment: .leading){
                            Text(note.name)
                                .font(.title)
                                .bold()
                            Text(note.description)
                                .fontWeight(.light)
                            Text(note.lastModified)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                self.newNoteModal = true
            }, label: {
                Image(systemName: "plus.circle.fill")
            }))
                .sheet(isPresented: $newNoteModal, content: {
                    NewNote(isOpen: $newNoteModal)
                })
                }
            }
        }
    }
}


struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
    }
}
