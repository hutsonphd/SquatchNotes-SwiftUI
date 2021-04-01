//
//  SessionStore.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import Foundation
import Firebase
import Combine

class SessionStore: ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    
    @Published var session: User? {didSet {self.didChange.send(self) }}

    @Published var userEmail: String = "\(Auth.auth().currentUser?.email ?? "")"
    
    var handle: AuthStateDidChangeListenerHandle?
    let authRef = Auth.auth()
    
    func listen() {
        handle = authRef.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
            } else {
                self.session = nil
            }
        })
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        authRef.signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        authRef.createUser(withEmail: email, password: password, completion: handler)
    }
    
   func signOut() {
        do {
            try authRef.signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind () {
        if let handle = handle {
            authRef.removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
