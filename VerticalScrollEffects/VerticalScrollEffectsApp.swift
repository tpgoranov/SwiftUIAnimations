//
//  VerticalScrollEffectsApp.swift
//  VerticalScrollEffects
//
//  Created by Todor Goranov on 22/02/2026.
//

import SwiftUI

@main
struct VerticalScrollEffectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(contacts: Contact.previewData)
        }
    }
}
