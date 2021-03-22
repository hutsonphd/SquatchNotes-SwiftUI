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
                    Image("login_logo")
                        .resizable()
                        .frame(width: 220, height: 220)
                        .scaledToFit()
                        .padding()
                    Text("SquatchNotes")
                        .font(.title)
                        .bold()
                    TextField("Email", text: $email)
                        .foregroundColor(Color("Text"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .foregroundColor(Color("Text"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                    HStack {
                        Spacer()
                        Button (action: {
                            sessionSession.signIn(email: email, password: password)
                        }, label: {
                            HStack {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                Text("Login")
                            }
                        })
                        .padding()
                        .background(Color("Blue"))
                        .cornerRadius(8)
                        Spacer()
                        Button (action: {
                            sessionSession.signUp(email: email, password: password)
                        }, label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up.fill")
                                Text("Sign up")
                            }
                        })
                        .padding()
                        .background(Color("Purple"))
                        .cornerRadius(8)
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .preferredColorScheme(.dark)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            
    }
}
