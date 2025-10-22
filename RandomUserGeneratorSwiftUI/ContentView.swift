//
//  ContentView.swift
//  RandomUserGeneratorSwiftUI
//
//  Created by Dhathri Bathini on 10/22/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel: UserViewModel
    init(userViewModel: UserViewModel){
        self.userViewModel = userViewModel
    }

    var body: some View {
        Text("Random User Details")
            .font(.title)
            .bold()
            .frame(width: 650, height: 100)
            .background(.cyan)
            .foregroundStyle(.white)
            .padding()

        List(userViewModel.user, id: \.self) { user in
            VStack(alignment:.leading, spacing: 20) {
                ImageView(userViewModel: userViewModel, user: user)
                HStack {
                    Text("\(user.name?.title ?? "")")
                    Text("\(user.name?.first ?? "")")
                    Text("\(user.name?.last ?? "")")
                }
                .font(.title2)
                .bold()
                Text("Email: \(user.email ?? "")")
                Text("Gender: \(user.gender ?? "")")
                Text("Phone Number: \(user.phone ?? "")")
            }
        }
        ButtonView(userViewModel: userViewModel)
    }
}

struct ImageView: View{
    @ObservedObject var userViewModel: UserViewModel
    var user: User
    var body: some View {
        if let imageUrl = user.picture?.large, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { state in
                    switch state {
                    case .success(let image):
                        image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    case .failure, .empty:
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.gray)
                    @unknown default:
                        EmptyView()
                }
            }
        }
    }
}

struct ButtonView: View{
    @ObservedObject var userViewModel: UserViewModel
    var body: some View {
        Button {
            Task {
                await userViewModel.getData()
            }
        } label: {
            Text("Generate Random User Data")
                .frame(width: 300, height: 80)
                .background(.yellow)
                .foregroundStyle(.white)
                .cornerRadius(30)
                .bold()
        }
    }
}
#Preview {
    ContentView(userViewModel: UserViewModel(shared: NetworkManager.shared))
}
