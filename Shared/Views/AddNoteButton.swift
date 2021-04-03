//
//  AddNoteButton.swift
//  SquatchNotes
//
//  Created by Hutson on 3/26/21.
//

import SwiftUI

struct AddNoteButton: View {
    
    let noteRepo = NoteRepository()
    
    @State var presentAddNewItem = false
    
    let newNote = Note(title: "Untitled Note", content: "", linkedNotes: [""], createdAt: Date(), updatedAt: Date())
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: .infinity, height: 60)
                    .foregroundColor(Color("Background"))
            }
            .edgesIgnoringSafeArea(.bottom)
            VStack {
                Spacer()
                Button(action: {noteRepo.addNote(newNote)}, label: {
                        Image(systemName: "plus")
                            .frame(width: 40   , height: 40)
                            .foregroundColor(Color("Text"))
                })
                .background(Color("Green"))
                .clipShape(Circle())
            }
        }
    }
}

struct AddNoteButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteButton()
            .preferredColorScheme(.dark)
    }
}
