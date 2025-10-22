//
//  UserViewModel.swift
//  RandomUserGeneratorSwiftUI
//
//  Created by Dhathri Bathini on 10/22/25.
//
import Combine

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: [User] = []
    var shared: NetworkManager
    
    init(shared: NetworkManager){
        self.shared = shared
    }
    
    func getData() async {
        user = await shared.getDataFromServer(url: Constants.endPoint)
    }
}
