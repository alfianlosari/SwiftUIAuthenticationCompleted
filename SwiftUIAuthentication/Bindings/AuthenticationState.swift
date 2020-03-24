//
//  AuthenticationState.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 16/11/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Combine
import AuthenticationServices
import FirebaseAuth

enum LoginOption {
    case signInWithApple
    case emailAndPassword(email: String, password: String)
}

class AuthenticationState: NSObject, ObservableObject {
    
    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?
    
    static let shared = AuthenticationState()
    
    private let auth = Auth.auth()
    fileprivate var currentNonce: String?
    
    override private init() {
        loggedInUser = auth.currentUser
        super.init()
        
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
        case .signInWithApple:
            handleSignInWithApple()
            
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

extension AuthenticationState: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    private func handleSignInWithApple() {
        let nonce = String.randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.sha256
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows[0]
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential, completion: handleAuthResultCompletion)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple error: \(error)")
        self.isAuthenticating = false
        self.error = error as NSError
    }
    
}
