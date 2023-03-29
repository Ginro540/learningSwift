//
//  PagaeControl.swift
//  inFiniteCarousel
//
//  Created by 古賀貴伍社用 on 2023/03/30.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var totalPage: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPage
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        control.allowsContinuousInteraction = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPage
        uiView.currentPage = currentPage
    }
    
    
}

