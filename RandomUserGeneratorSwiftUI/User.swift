//
//  User.swift
//  RandomUserGeneratorSwiftUI
//
//  Created by Dhathri Bathini on 10/22/25.
//

struct User: Decodable, Hashable {
    var gender: String?
    var email: String?
    var phone: String?
    var name: name?
    var picture: pictureSize?
}

struct pictureSize: Decodable, Hashable {
    var large: String?
}

struct name: Decodable, Hashable {
    var title: String?
    var first: String?
    var last: String?
}

struct userResult: Decodable {
    var results: [User]?
}

struct GenderCount: Identifiable, Hashable {
    let gender: String
    let count: Int
    var id: String { gender }
}
