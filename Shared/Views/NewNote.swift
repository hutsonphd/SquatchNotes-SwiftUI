//
//  NewNote.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI

struct NewNote: View {
    
    @Binding var isOpen: Bool
    @State var newName = ""
    @ObservedObject var viewModel = NotesViewModel()
    
    var body: some View {
        NavigationView {
        VStack {
            TextField("Enter a note name", text: $newName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
            Button(action: {
                viewModel.createNote(name: newName, handler: { self.isOpen = false
                })
            }, label: {
                Text("Create")
                    .padding()
            })
            Spacer()
        }
        .padding()
        .navigationBarTitle("New Note")
        }
    }
}

struct NewNote_Previews: PreviewProvider {
    static var previews: some View {
        NewNote(isOpen: .constant(true))
    }
}
