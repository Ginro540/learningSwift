//
//  ContentView.swift
//  inFiniteCarousel
//
//  Created by 古賀貴伍社用 on 2023/03/29.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Infinite Carousel")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
