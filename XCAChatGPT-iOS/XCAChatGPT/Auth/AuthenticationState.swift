//
//  AuthenticationState.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 16/11/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//


import Firebase
import FirebaseAuth
import Observation

enum LoginOption {
    case emailAndPassword(email: String, password: String)
}

func getAuthToken() async -> String? {
    try? await Auth.auth().currentUser?.getIDToken()
}


@Observable
class AuthenticationState {
    
    var loggedInUser: User? = nil
    var isAuthenticating = false
    var error: NSError?
    private let auth: Auth
    
    fileprivate var currentNonce: String?
    
    init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        loggedInUser = auth.currentUser
        
        auth.addStateDidChangeListener(authStateChanged)
    }
    
    private func authStateChanged(with auth: Auth, user: User?) {
        guard user != self.loggedInUser else { return }
        self.loggedInUser = user
    }
    
    func login(with loginOption: LoginOption) {
        self.isAuthenticating = true
        self.error = nil
                
        switch loginOption {
        case let .emailAndPassword(email, password):
            handleSignInWith(email: email, password: password)
        }
    }
    
    func signup(email: String, password: String, passwordConfirmation: String) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password and confirmation does not match"])
            return
        }
        
        self.isAuthenticating = true
        self.error = nil
        auth.createUser(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    private func handleSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    
    private func handleAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
        DispatchQueue.main.async {
            self.isAuthenticating = false
            if let user = auth?.user {
                self.loggedInUser = user
            } else if let error = error {
                self.error = error as NSError
            }
        }
    }
  
    func signout() {
        try? auth.signOut()
    }
    
}
