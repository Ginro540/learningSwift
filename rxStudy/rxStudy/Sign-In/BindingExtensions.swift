//
//  BindingExtensions.swift
//  rxStudy
//
//  Created by 古賀貴伍社用 on 2023/03/04.
//

import RxSwift
import RxCocoa
import UIKit


enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

extension ValidationResult {
    // getを省略したコンピューティドプロパティ
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}





extension ValidationResult:  CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case .validating:
            return "validating ..."
        case let .failed(message):
            return message
        }
    }
}

