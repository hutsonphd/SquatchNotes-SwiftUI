//
//  AddNoteButton.swift
//  SquatchNotes
//
//  Created by Hutson on 3/26/21.
//

import SwiftUI

struct AddNoteButton: View {
    
    let notes = NotesViewModel()
    
    var body: some View {
        VStack {
            Button(action: {notes.addNote()}, label: {
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("Text"))
            })
            .background(Color("Green"))
            .clipShape(Circle())
        }
    }
}

struct AddNoteButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteButton()
            .preferredColorScheme(.dark)
    }
}
