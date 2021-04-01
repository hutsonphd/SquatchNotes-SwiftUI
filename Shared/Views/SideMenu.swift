//
//  SideMenu.swift
//  SquatchNotes
//
//  Created by Hutson on 3/27/21.
//

import SwiftUI
import FirebaseAuth

struct SideMenu: View {
    
    @ObservedObject var session = SessionStore()
    @Binding var sideNavShowing: Bool
    
    var body: some View {
        ZStack (alignment: .top){
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("Green")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    Image("hutson_mountains_logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Text(session.userEmail)
                        .font(.custom("Cabin-Regular", size: 16))
                        .foregroundColor(Color("Text"))
                        .padding(.top)
                    SignOut()
                        .padding(.top, 40
                        )
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(sideNavShowing: .constant(true))
            .preferredColorScheme(.dark)
    }
}
