//
//  NoteRow.swift
//  SquatchNotes
//
//  Created by Hutson on 3/26/21.
//

import SwiftUI

struct NoteRow: View {
    
    @ObservedObject var noteCellVM: NoteCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(noteCellVM.note.title)
//            Text("Untitled Note")
                .font(.custom("Cabin-Bold", size: 24))
                .padding(.top, 4)
            Text(noteCellVM.note.updatedAtString)
//            Text("March 31, 2021 05:31")
                .font(.custom("Cabin-Regular", size: 16))
                .padding(.top, 10)
        }
    }
}


//struct NoteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteRow()
//            .preferredColorScheme(.dark)
//    }
//}
