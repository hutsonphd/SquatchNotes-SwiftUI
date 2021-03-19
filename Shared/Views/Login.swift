//
//  Login.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var sessionSession = SessionStore()
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button (action: {
                    sessionSession.signIn(email: email, password: password)
                }, label: {
                    Text("Login")
                })
                
                Button (action: {
                    sessionSession.signUp(email: email, password: password)
                }, label: {
                    Text("Sign up")
                })
            }
            
        }
        .navigationBarTitle("Welcome")
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
