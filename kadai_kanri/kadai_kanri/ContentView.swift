//
//  ContentView.swift
//  kadai_kanri
//
//  Created by K.U on 2022/04/21.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var isAddTask: Bool = false
    var body: some View {
        TabView {
            TimeTable()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("時間割")
                }
            TaskManagementView() //realmオブジェクトを渡す
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("課題管理")
                }
            AddAssignment(state: $isAddTask)
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                    Text("課題追加")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
