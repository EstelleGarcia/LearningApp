//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
