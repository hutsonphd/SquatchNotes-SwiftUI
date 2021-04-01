//
//  SignUpView.swift
//  SquatchNotes
//
//  Created by Hutson on 4/1/21.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @ObservedObject var session = SessionStore()
    
    func signUp() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Create Account")
                .font(.custom("Cabin-Bold", size: 32))
            
            Text("Sign up to get started")
                .font(.custom("Cabin-Medium", size: 18))
            
            VStack(spacing: 18) {
                TextField("Email address", text: $email)
                    .font(.custom("Cabin-Regular", size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("Green"), lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.custom("Cabin-Regular", size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("Green"), lineWidth: 1))
            }
            .padding(.vertical, 64)
            
            Button(action: signUp) {
                Text("Create Account")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(Color(.white))
                    .font(.custom("Cabin-Bold", size: 14))
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Green"), Color("Blue")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
            
            if (error != "") {
                Text(error)
                    .font(.custom("Cabin-Medium", size: 14))
                    .foregroundColor(Color("Red"))
                    .padding()
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}




struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}
