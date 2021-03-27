//
//  NoteEditor.swift
//  SquatchNotes
//
//  Created by Hutson on 3/26/21.
//

import SwiftUI
import SwiftDown

struct NoteEditor: View {
    
    @StateObject var myNote = NotesViewModel()
    
    let note: Note
    @State private var inputTitle = "" 
    @State private var inputContent = ""
    @ObservedObject var noteData = NotesViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            HStack {
                VStack (alignment: .leading, spacing: 10){
                    TextField("\(note.title)",
                              text: $inputTitle,
                              onEditingChanged: {_ in print("changed")},
                              onCommit: {noteData.updateNote(id: note.id, title: self.inputTitle, content: self.inputContent)}
                        )
                        .font(.custom("Cabin-Regular", size: 32))
                        .foregroundColor(Color("Text"))
                    SwiftDownEditor(text: $inputContent)
                        .font(.custom("Cabin-Regular", size: 18))
                        .foregroundColor(Color("Text"))
                    Spacer()
                }
                .foregroundColor(Color("Text"))
                Spacer()
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {noteData.updateNote(id: note.id, title: self.inputTitle, content: self.inputContent)}, label: {
                Text("Update")
                    .font(.custom("Cabin-Regular", size: 20))
            }))
        }
    }
}
