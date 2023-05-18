//
//  TimesTableApp.swift
//  TimesTable
//
//  Created by Anastasiia Solomka on 17.05.2023.
//

import SwiftUI

@main
struct TimesTableApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsView(timesTableSelection: 2, questionsAmountSelection: 5)
        }
    }
}
