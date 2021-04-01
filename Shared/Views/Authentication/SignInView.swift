//
//  SignInView.swift
//  SquatchNotes
//
//  Created by Hutson on 4/1/21.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @ObservedObject var session = SessionStore()
    
    func signIn() {
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
                Image("login_logo")
                    .resizable()
                    .frame(width: 220, height: 220)
                    .scaledToFit()
                    .padding()
                Text("Squatch Notes")
                    .font(.custom("ArchitectsDaughter-Regular", size: 40))
                    .bold()
                    .foregroundColor(Color("Text"))
            Text("Sign in to continue")
                .font(.custom("ArchitectsDaughter-Regular", size: 18))
                .foregroundColor(.gray)
            
            VStack(spacing: 18) {
                TextField("Email address", text: $email)
                    .font(.custom("Cabin-Regular", size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.custom("Cabin-Regular", size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 1))
            }
            .padding(.vertical, 30)
            
            Button(action: signIn) {
                Text("Sign in")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
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
            
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text("I'm a new user.")
                        .font(.custom("Cabin-Regular", size: 14))
                        .foregroundColor(.primary)
                    
                    Text("Create an account")
                        .font(.custom("Cabin-bold", size: 14))
                        .foregroundColor(Color("Blue"))
                }
            }
            Spacer()
        }
        .padding(.horizontal, 32)
        .background(Color("Background"))
        .ignoresSafeArea()
        
    }
}


struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(SessionStore())
    }
}
