//
//  NotesList.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI

struct NotesList: View {
    
   @ObservedObject var viewModel = NoteDataModel() // (/1)
    
    init () {
        viewModel.fetchData()
    }

        var body: some View {
            ZStack {
                NavigationView {
                List(viewModel.notes) { note in // (2)
                    NavigationLink(destination: NotesEditor(),
                                   label: {
                                        Text(note.body)
                                            .font(.headline)
                                            .foregroundColor(Color("Text"))
                                            .bold()
                                    
                                   })
                }
                .navigationBarTitle("Notes")
                .navigationBarItems(trailing: SignOut().padding())
                }
                .background(Color("Background"))
            }
            .background(Color("Background"))
        }
      }


struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
            .preferredColorScheme(.dark)
            
    }
}
