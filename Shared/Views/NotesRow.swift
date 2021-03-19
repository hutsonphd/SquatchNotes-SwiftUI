//
//  NotesRow.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI


struct NotesRow: View {
   @ObservedObject private var viewModel = NotesViewModel()
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading){
                Text("note.name")
                    .font(.title)
                    .bold()
                Text("note.description")
                    .fontWeight(.light)
                Text("note.lastModified")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            Spacer()
            
            Image(systemName: "photo.fill")
                .padding()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
        }
    }
}

struct NotesRow_Previews: PreviewProvider {
    static var previews: some View {
        NotesRow()
    }
}
