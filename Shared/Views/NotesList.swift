//
//  NotesList.swift
//  SquatchNotes
//
//  Created by Hutson on 3/27/21.
//

import SwiftUI

struct NotesList: View {
    
    @ObservedObject var noteListVM = NoteListViewModel()
    

    
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
                            .padding()
                    })
                .listRowBackground(Color("Background"))
            }
            .onDelete(perform: noteListVM.noteRepo.deleteNoteList)
        }
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
