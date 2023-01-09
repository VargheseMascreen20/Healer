//
//  CircularImage.swift
//  Healer
//
//  Created by VARGHESE T MASCREEN on 08/01/23.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        Image("person.fill")
            .resizable()
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
            .frame(width:150,height: 150)
            
    }
}

//struct CircleImage_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleImage(image: $image)
//    }
//}
