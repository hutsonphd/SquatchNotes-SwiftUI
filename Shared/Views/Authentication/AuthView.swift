//
//  AuthView.swift
//  SquatchNotes
//
//  Created by Hutson on 4/1/21.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignInView()
                .navigationBarHidden(true)
        }

    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
