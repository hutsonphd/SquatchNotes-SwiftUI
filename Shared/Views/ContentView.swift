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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
            .preferredColorScheme(.dark)
    }
}
