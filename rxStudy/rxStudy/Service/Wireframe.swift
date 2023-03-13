//
//  Wireframe.swift
//  rxStudy
//
//  Created by 古賀貴伍社用 on 2023/03/05.
//

import Foundation
import RxSwift
import UIKit

enum RetryResult {
    case retry
    case cancel
}

protocol Wireframe {
    func open(url:URL)
    func promptFor<Action: CustomStringConvertible>(_ message: String, cancelAction: Action, action: [Action]) -> Observable<Action>
}


