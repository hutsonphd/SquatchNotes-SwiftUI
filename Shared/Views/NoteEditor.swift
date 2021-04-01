//
//  NoteEditor.swift
//  SquatchNotes
//
//  Created by Hutson on 3/26/21.
//

import SwiftUI
import HighlightedTextEditor

struct NoteEditor: View {

    @ObservedObject var noteRepo = NoteRepository()
    @ObservedObject var noteCellVM: NoteCellViewModel
    
    var onCommit: (Note) -> (Void) = { _ in }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            HStack {
                VStack (alignment: .leading, spacing: 10){
                    TextField("Add note title",
                              text: $noteCellVM.note.title, onCommit: {self.onCommit(self.noteCellVM.note)}
                        )
                        .font(.custom("Cabin-Regular", size: 32))
                        .foregroundColor(Color("Text"))
                    HighlightedTextEditor(text: $noteCellVM.note.content,
                                          highlightRules: .markdown,
                                          onCommit: {self.onCommit(self.noteCellVM.note)})
                        .font(.custom("Cabin-Regular", size: 18))
                        .foregroundColor(Color("Text"))
                    Spacer()
                }
                .foregroundColor(Color("Text"))
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}
