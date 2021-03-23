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
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                VStack {
                    Login_Image()
                    VStack {
                        TextField("Email", text: $email)
                        SecureField("Password", text: $password)
                        }
                        .font(.custom("Cabin-Bold", size: 18))
                        .foregroundColor(Color("Text"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    HStack {
                        Spacer()
                        Button (action: {
                            sessionSession.signIn(email: email, password: password)
                        }, label: {
                            logInButton()
                        })
                        Spacer()
                        Button (action: {
                            sessionSession.signUp(email: email, password: password)
                        }, label: {
                            signUpButton()
                        })
                        Spacer()
                        }
                    .padding()
                    Spacer()
                }
            }
            Spacer()
                       
        }
        .navigationBarTitle("Welcome")
    }
}

// MARK: - Login Image

struct Login_Image: View {
    var body: some View {
        VStack {
            Image("login_logo")
                .resizable()
                .frame(width: 220, height: 220)
                .scaledToFit()
                .padding()
            Text("Squatch Notes")
                .font(.custom("ArchitectsDaughter-Regular", size: 40))
                .bold()
                .foregroundColor(Color("Text"))
        }
    }
}

// MARK: - SignUp Button

struct signUpButton: View {
    var body: some View {
        HStack {
            Image(systemName: "square.and.arrow.up.fill")
            Text("Sign up")
                .font(.custom("Cabin-Bold", size: 18))
        }
        .padding()
        .background(Color("Purple"))
        .cornerRadius(8)
    }
}

// MARK: - LogIn Button

struct logInButton: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
            Text("Login")
                .font(.custom("Cabin-Bold", size: 18))
        }
        .padding()
        .background(Color("Blue"))
        .cornerRadius(8)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .preferredColorScheme(.dark)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            
    }
}
