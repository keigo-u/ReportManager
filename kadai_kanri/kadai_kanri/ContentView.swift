//
//  ContentView.swift
//  kadai_kanri
//
//  Created by K.U on 2022/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            TaskManagementView()
                .tabItem {
                    Text("課題管理")
                }
            TimeTable()
                .tabItem {
                    Text("時間割")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}