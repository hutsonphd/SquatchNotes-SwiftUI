//
//  NotesList.swift
//  SquatchNotes
//
//  Created by Hutson on 3/23/21.
//

import SwiftUI

struct NotesList: View {

    @ObservedObject var viewModel = NoteDataModel()
    
    init () {
        viewModel.getNotes()
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                LazyVStack (alignment: .leading) {
                    HStack {
                        Text("Notes")
                            .font(.custom("Cabin-Bold", size: 40))
                            .padding(.horizontal)
                            .foregroundColor(Color("Text"))
                        Spacer()
                        SignOut()
                            .padding()
                    }
                    ForEach(viewModel.notes) { note in
                        VStack (alignment: .leading){
                            Text(note.body)
                                .font(.custom("Cabin-Bold", size: 24))
                                .foregroundColor(Color("Text"))
                            Text(note.createdAtString)
                                .font(.custom("Cabin-Regular", size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .onTapGesture {
                        print("tapped")
                    }
                }
            }
        }
        

    }
}

struct NotesRow_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
            .preferredColorScheme(.dark)
    }
}
