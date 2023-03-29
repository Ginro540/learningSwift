//
//  OffsetReader.swift
//  inFiniteCarousel
//
//  Created by 古賀貴伍社用 on 2023/03/30.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool,  completion: @escaping (CGRect) -> ()) -> some View {
        self
            .frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    }
                }
            }
    }
    
}
