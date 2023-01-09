//
//  HomeView.swift
//  Healer
//
//  Created by VARGHESE T MASCREEN on 03/01/23.
//

import SwiftUI
import SDWebImageSwiftUI
struct HomeView: View {
    @State var shouldShowLogOutOptions = false
    
    @ObservedObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .leading) {
                
                //                Text("User : \(vm.userModel?.uid ?? "")")
                Text("Choose the doctor you want to consult")
                    .fontWeight(.ultraLight)
                    .padding(.leading)
                SearchBar(text: .constant(""))
                
                doctorsView
                
                
                
                
            }
            
            .navigationTitle("Healer")
            .toolbar{
                customToolBar
            }
            
            
            //            .overlay(
            //                newMessageButton,alignment: .bottom)
            
        }
    }
    
    private var customToolBar: some View {
        VStack(){
            
            
            Button{
                shouldShowLogOutOptions.toggle()
            }label: {
                //                Image(systemName: "gear")
                //                    .font(.system(size:24, weight: .bold))
                //                    .foregroundColor(Color(.label))
                
                WebImage(url: URL(string: vm.userModel?.profileImageUrl ?? "")).resizable()
                    .scaledToFill()
                    .frame(width:30 , height: 30)
                    .clipped()
                    .cornerRadius(50)
                    .overlay(RoundedRectangle(cornerRadius: 44)
                        .stroke(Color(.label), lineWidth: 1))
                    .shadow(radius: 5)
                
            }
        }.padding()
            .actionSheet(isPresented: $shouldShowLogOutOptions){
                .init(title: Text("Settings"),message: Text("Select the option you want to perform"), buttons: [
                    //                            .default(Text("DEFAULT BUTTON")),
                    .default(Text("View Profile"),action: {
                        
                    }),
                    .destructive(Text("Sign Out"),action: {
                        print("Handle Sign Out")
                        vm.handleSignOut()
                    }),
                    .cancel()
                ])
            }
            .fullScreenCover(isPresented:  $vm.isUserCurrentlyLoggedOut,onDismiss: nil){
                LoginSignUpView(didCompleteLoginProcess: {
                    self.vm.isUserCurrentlyLoggedOut = false
                    self.vm.fetchCurrentUser()
                })
            }
        
    }
    private var doctorsView: some View{
        ScrollView{
            
            VStack {
                CardView()
            }.padding(.bottom, 50)
            
        }
        
    }
    
    @State var shouldShowNewMessageScreen = false
    private var newMessageButton: some View{
        Button{
            shouldShowNewMessageScreen.toggle()
        }
    label:{
        HStack {
            Spacer()
            Text("+ New Message")
                .font(.system(size: 16, weight: .bold))
            Spacer()
            
        }
        .foregroundColor(Color.white)
        .padding(.vertical)
        .background(Color.blue)
        .cornerRadius(32)
        .padding(.horizontal)
        .shadow(radius: 5)
        
        
    }.fullScreenCover(isPresented: $shouldShowNewMessageScreen){
        //        CreateNewMessageView()
    }
    }
   
    
    struct MainMessagesView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .preferredColorScheme(.dark)
            HomeView()
        }
    }
}

