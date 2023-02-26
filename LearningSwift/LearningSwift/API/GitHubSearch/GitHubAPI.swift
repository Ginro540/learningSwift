//
//  GitHubAPI.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/23.
//

import Foundation

struct GitHubAPI<T:Codable> {
        
    func request(with urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw APIClientError.invalidURL
        }
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                throw APIClientError.responseError
            }
            switch httpStatus.statusCode {
            case 200 ..< 400:
                return try JSONDecoder().decode(T.self, from: data)
            case 400... :
                throw APIClientError.badStatus(statusCode:httpStatus.statusCode)
            default:
                fatalError()
                break
            }
        } catch {
            throw APIClientError.serverError(error)
        }
    }
}
