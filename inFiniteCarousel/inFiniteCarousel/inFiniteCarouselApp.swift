//
//  inFiniteCarouselApp.swift
//  inFiniteCarousel
//
//  Created by 古賀貴伍社用 on 2023/03/29.
//

import SwiftUI

@main
struct inFiniteCarouselApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
