//
//  NoteRow.swift
//  SquatchNotes
//
//  Created by Hutson on 3/26/21.
//

import SwiftUI

struct NoteRow: View {
    
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.custom("Cabin-Bold", size: 24))
            Text(note.updatedAtString)
                .font(.custom("Cabin-Regular", size: 16))
        }
    }
}
