//
//  GitHubSearchResult.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/23.
//

import Foundation

struct SearchTableSectionModel: Codable {
    var items: [Repository]
}

struct Repository: Codable, Equatable, Identifiable {
    
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
    }
}
