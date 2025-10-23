//
//  ContentView.swift
//  RandomUserGeneratorSwiftUI
//
//  Created by Dhathri Bathini on 10/22/25.
//

import SwiftUI
import ActivityIndicatorView
import Shimmer

struct ContentView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var isLoading = true

    var body: some View {
        VStack {
            header
            if isLoading {
                List{
                    HStack(spacing: 16) {
                        Circle().fill(.gray.opacity(0.2))
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 6).fill(.gray.opacity(0.2)).frame(height: 14)
                            RoundedRectangle(cornerRadius: 6).fill(.gray.opacity(0.2)).frame(width: 160, height: 12)
                            RoundedRectangle(cornerRadius: 6).fill(.gray.opacity(0.2)).frame(width: 120, height: 12)
                        }
                    }
                    .shimmering(active: true, duration: 1.2, bounce: true)
            }
            ActivityIndicatorView(isVisible: $isLoading, type: .scalingDots())
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.blue)
            } else {
                List(userViewModel.user, id: \.self) { user in
                    VStack(alignment: .leading, spacing: 20) {
                        ImageView(userViewModel: userViewModel, user: user)
                        HStack {
                            Text(user.name?.title ?? "")
                            Text(user.name?.first ?? "")
                            Text(user.name?.last ?? "")
                        }
                        .font(.title2).bold()
                        Text("Email: \(user.email ?? "")")
                        Text("Gender: \(user.gender ?? "")")
                        Text("Phone Number: \(user.phone ?? "")")
                    }
                }
            }

            ButtonView(userViewModel: userViewModel, isLoading: $isLoading)
        }
    }

    private var header: some View {
        Text("Random User Details")
            .font(.title).bold()
            .frame(width: 650, height: 100)
            .background(.cyan)
            .foregroundStyle(.white)
            .padding()
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
    @Binding var isLoading: Bool
    var body: some View {
        Button {
            Task {
                await userViewModel.getData()
                isLoading = false
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
