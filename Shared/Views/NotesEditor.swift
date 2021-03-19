//
//  NotesEditor.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI

struct NotesEditor: View {
    var note: NoteData
    
    @State private var inputText = ""
    @State private var wordCount: Int = 0
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            TextEditor(text: $inputText)
                .font(.body)
                .padding()
                .padding(.top, 20)
                .lineSpacing(20)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .onChange(of: inputText) { value in
                                    let words = inputText.split { $0 == " " || $0.isNewline }
                                    self.wordCount = words.count
                                }
            Text("\(wordCount) words")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
        .navigationTitle(note.name)
    }
}

struct NotesEditor_Previews: PreviewProvider {
    static var previews: some View {
        NotesEditor(note: NoteData(id: "10101", name: "Sample Note", body: "Get with it", description: "description", lastModified: ""))
    }
}
