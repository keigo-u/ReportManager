//
//  kadai_kanriApp.swift
//  kadai_kanri
//
//  Created by K.U on 2022/04/21.
//

//test e205708

import SwiftUI
import RealmSwift
import KeyboardObserving

let realmApp = RealmSwift.App(id: "task_manager-qiurl")

@main
struct kadai_kanriApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Keyboard())
        }
    }
}

extension Color {
    static let light_beige = Color("light_beige")
    static let light_green = Color("light_green")
    static let beige = Color("beige")
    static let light_gray = Color("light_gray")
}
