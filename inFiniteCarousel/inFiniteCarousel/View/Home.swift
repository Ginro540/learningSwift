//
//  home.swift
//  inFiniteCarousel
//
//  Created by 古賀貴伍社用 on 2023/03/29.
//

import SwiftUI

struct Home: View {
    
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    
    @State private var fakePages: [Page] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TabView(selection: $currentPage, content: {
                ForEach(fakePages) { Page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(Page.id.uuidString)
                        .offsetX(currentPage == Page.id.uuidString) { rect in
                            
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(Page)))
                            /// Converting Page Offseat into Progress
                            let pageProgress = pageOffset / size.width
                            /// Infinite Carousel Logic
                            if -pageProgress < 1.0 {
                                if fakePages.indices.contains(fakePages.count - 1){
                                    currentPage = fakePages[fakePages.count - 1].id.uuidString
                                }
                            }
                            if -pageProgress > CGFloat(fakePages.count - 1) {
                                if fakePages.indices.contains(1){
                                    currentPage = fakePages[1].id.uuidString
                                }
                            }
                        }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPage: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        .onAppear {
            guard fakePages.isEmpty else { return }
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown]{
                listOfPages.append(.init(color: color))
            }
            
            fakePages.append(contentsOf: listOfPages)
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                firstPage.id = .init()
                lastPage.id = .init()
                fakePages.append(firstPage)
                fakePages.insert(lastPage, at: 0)
            }
        }
    }
    
    func fakeIndex(_ of: Page) -> Int {
        return fakePages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

struct home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
