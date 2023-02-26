//
//  APIClientError.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/26.
//

import Foundation

enum APIClientError: Error {
    case invalidURL
    case responseError
    case noData
    case badStatus(statusCode:Int)
    case serverError(Error)
}
