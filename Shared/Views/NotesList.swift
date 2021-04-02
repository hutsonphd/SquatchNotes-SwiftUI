//
//  NotesList.swift
//  SquatchNotes
//
//  Created by Hutson on 3/27/21.
//

import SwiftUI
import SwiftUIX
import FirebaseFirestore

struct NotesList: View {
    
    @ObservedObject var noteListVM = NoteListViewModel()
    @ObservedObject var noteRepo = NoteRepository()
    
    
//    init() {
//        noteListVM.noteRepo.getNotes()
//    }
//
//    let notes = testDataNotes
//
    var body: some View {
        List {
            ForEach(noteListVM.noteCellViewModels) { noteCellVM in
                NavigationLink(
                    destination: NoteEditor(noteCellVM: noteCellVM),
                    label: {
                        NoteRow(noteCellVM: noteCellVM)
                    })
                    .listRowBackground(Color("Background"))
            }
            .onDelete(perform: deleteNote)
        }
        .background(Color("Background"))
    }
    
    private func deleteNote(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let note = noteListVM.noteRepo.notes[index]
            let db = Firestore.firestore()
            db.collection("notes").document(note.id!).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    noteRepo.getNotes()
                }
            }
        }
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
