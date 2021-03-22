//
//  SignOut.swift
//  SquatchNotes
//
//  Created by Hutson on 3/21/21.
//

import SwiftUI


struct SignOut: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var session = SessionStore()
    
    var body: some View {
        Button (action: {
            session.signOut()
        }, label: {
            HStack {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color("Text"))
            }
            .background(Color("Purple"))
        })
        .clipShape(Circle())
    }
}

struct SignOut_Previews: PreviewProvider {
    static var previews: some View {
        SignOut()
            .preferredColorScheme(.dark)
    }
}
