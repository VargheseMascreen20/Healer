//
//  HomeViewModel.swift
//  Healer
//
//  Created by VARGHESE T MASCREEN on 06/01/23.
//

import Foundation
class HomeViewModel: ObservableObject{
    @Published var errorMessage = ""
    @Published var userModel: UserModel?
    @Published var isUserCurrentlyLoggedOut = false

    
    init(){
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut =  FirebaseManager.shared.auth.currentUser?.uid == nil     }
        fetchCurrentUser()
    }
    
 
    
    func fetchCurrentUser(){
        guard let uid =
                FirebaseManager.shared.auth.currentUser?.uid else{
            self.errorMessage = "Could not find Firebase UID"
            return
            
        }
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument{ snapshot, error in
            if let error = error{
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user: ", error)
                return
            }
            guard let data = snapshot?.data() else {
                self.errorMessage = "No Data Found"
                return}
            
            self.userModel = .init(data: data)
        }
    }
    
    
    func handleSignOut(){
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
