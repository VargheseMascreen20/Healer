//
//  UserModel.swift
//  Healer
//
//  Created by VARGHESE T MASCREEN on 06/01/23.
//

import Foundation
struct UserModel: Identifiable{
    
    var id:String{
        uid
    }
    let uid, email, profileImageUrl: String
    
    init(data:[String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
    
}
