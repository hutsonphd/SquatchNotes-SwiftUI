//
//  NotesEditor.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI
import SwiftDown

struct NotesEditor: View {
    
    @State private var inputText = ""
    @State private var wordCount: Int = 0
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Color("Background")
                .ignoresSafeArea(.all)
            SwiftDownEditor(text: $inputText)
                .insetsSize(40)
                .theme(Theme.BuiltIn.defaultLight.theme())
                .padding()
                .padding(.top, 20)
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .onChange(of: inputText) { value in
                                    let words = inputText.split { $0 == " " || $0.isNewline }
                                    self.wordCount = words.count
                                }
                .background(Color("Background"))
            Text("\(wordCount) words")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
    }
}

struct NotesEditor_Previews: PreviewProvider {
    static var previews: some View {
        NotesEditor()
    }
}
