//
//  LoginSignUpView.swift
//  Healer
//
//  Created by VARGHESE T MASCREEN on 03/01/23.
//

import SwiftUI
import FirebaseAuth



struct LoginSignUpView: View {
    
    let didCompleteLoginProcess: () -> ()
    
    
    @State var isLoginMode = true
    @State var email = ""
    @State var password = ""
    @State var bloodGroup = ""
    @State var placeOfResidence = ""
    @State var loginStatusMessage = ""
    @State var shouldShowImagePicker = false
    @State var userIsLoggedIn = false
    
    @State private var selectedImage: UIImage?
    @State private var placeholderImage = Image(systemName: "person.fill")
    
    
    
    
    //    init(){
    //        FirebaseApp.configure()
    //    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                
                
                VStack(spacing: 16){
//                    Text(isLoginMode ? "Login" : "Create Account")
//                        .fontWeight(.bold)
                    Picker(selection: $isLoginMode,
                           label: Text("Picker here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle()).background(.blue)
                    if !isLoginMode{
                        Button{
                            shouldShowImagePicker.toggle()
                        }
                    label:{
                        
                        VStack{
                            
                            if let image = self.image{
                                
                                Image(uiImage: image).resizable().frame(width: 150 , height: 150).scaledToFill().cornerRadius(150)
                                
                            }else{
                                
                                Image(systemName: "person.fill").font(.system(size:64)).padding().foregroundColor(Color(.black))
                            }
                        }.overlay(RoundedRectangle(cornerRadius: 150).stroke(Color.black,lineWidth: 3))
                        
                    }
                        
                    }
                    
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        
                        SecureField("Password", text: $password)
                        
                        if !isLoginMode{
                            TextField("Blood Group", text: $bloodGroup)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            TextField("Place of residence", text: $placeOfResidence)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                
                            
                        }
                        
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button{
                        handleAction()
                    } label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account").foregroundColor(Color.white).padding(.vertical,16).font(.system(size: 14,weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                    Text(self.loginStatusMessage).foregroundColor(.red)
                }.padding()
                //                    .onAppear{
                //                        Auth.auth().addStateDidChangeListener{auth, user in
                //                            if user != nil{
                //                                userIsLoggedIn.toggle()
                //                            }
                //
                //                        }
                //                    }
                
                
            }
//            .background(.thickMaterial, in: RoundedRectangle(cornerRadius:50 ,style: .circular))
            .background(Color(.init(white: 0 ,alpha:0.05)).ignoresSafeArea())
            .navigationTitle("Healer")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        .sheet(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(selectedImage: self.$image)
            
            
        }
    }
    @State var image = UIImage()
    
    private func handleAction(){
        if isLoginMode{
            loginUser()
            print("Should Login to Firebase with Existing Credentials")
        }
        else{
            createNewAccount()
            print("Register a new Account with firebase..")
        }
    }
    private func loginUser(){
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password){
            result ,err in
            if let err = err{
                print("Failed to login user",err)
                self.loginStatusMessage  = "Failed to login user \(err)"
                return
            }
            print("Successfully logged in user : \(result?.user.uid ?? "")")
            self.loginStatusMessage  = "Successfully logged in user : \(result?.user.uid ?? "")"
            //            NavigationLink("Home",destination: HomeView())
            
            self.didCompleteLoginProcess()
            self.navigateToHomeView()
            
        }
    }
    private func createNewAccount(){
        
        if self.image == nil {
            self.loginStatusMessage = "Please select an avatar image"
            return
        }
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err{
                print("Failed to create user",err)
                self.loginStatusMessage  = "Failed to create user \(err)"
                return
            }
            print("Successfully created user : \(result?.user.uid ?? "")")
            self.loginStatusMessage  = "Successfully created user : \(result?.user.uid ?? "")"
            persistImageToStorage()
        }
    }
    private func persistImageToStorage(){
        //        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid )
        guard let imageData = self.image.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData,metadata: nil){ metadata ,err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to storage: \(err)"
                return
            }
            
            ref.downloadURL{ url,err in
                if let err = err{
                    self.loginStatusMessage = "Failed to retrieve downurl: \(err)"
                    return
                }
                self.loginStatusMessage = "Successfulyy stored image with url: \(url?.absoluteString ?? "")"
                guard let url = url else {return}
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    func navigateToHomeView() {
        // Navigate to the home view
        let homeView = HomeView()
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: homeView)
    }
    private func storeUserInformation(imageProfileUrl: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{
            return
        }
        let userData = ["email": self.email,"uid": uid,"profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("/users").document(uid).setData(userData){ err in
            if let err = err{
                print(err)
                self.loginStatusMessage = "\(err)"
                return
            }
            print("Success!")
            self.didCompleteLoginProcess()
        }
    }
    
}

struct ContentView_Previews1 : PreviewProvider {
    static var previews: some View {
        LoginSignUpView(didCompleteLoginProcess: {})
    }
}



