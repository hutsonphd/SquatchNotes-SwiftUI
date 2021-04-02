//
//  ContentView.swift
//  Shared
//
//  Created by Hutson on 3/18/21.
//

import SwiftUI

struct ContentView: View {

//    @EnvironmentObject var session: SessionStore
    @ObservedObject var noteRepo = NoteRepository()
    @ObservedObject var session = SessionStore()
    
    func getUser() {
        session.listen()
    }

    
    init() {
        noteRepo.loadData()
//        session.listen()
    }
    

    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    VStack{
                        NavigationView {
                            NotesList()
                                .navigationBarTitle("Notes")
                                .navigationBarItems(trailing: HStack {
                                    AddNoteButton()
                                    SignOut()
                                })
                        }
                    }
                    .background(Color("Background"))
                }
                .edgesIgnoringSafeArea(.all)
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        .fullScreenCover(isPresented: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/, content: {
            AuthView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
            .preferredColorScheme(.dark)
    }
}
