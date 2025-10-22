//
//  NetworkManager.swift
//  RandomUserGeneratorSwiftUI
//
//  Created by Dhathri Bathini on 10/22/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getDataFromServer(url: String) async -> [User] {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let user = try decoder.decode(userResult.self, from: data)
            return user.results ?? []
        }
        catch {
            print("Error fetching/parsing the data")
            return []
        }
    }
}
