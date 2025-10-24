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

extension Array where Element == User {
    func genderCounts() -> [GenderCount] {
        Dictionary(grouping: self, by: { ($0.gender ?? "Unknown").capitalized })
            .map { GenderCount(gender: $0.key, count: $0.value.count) }
            .sorted { $0.gender < $1.gender }
    }
}
