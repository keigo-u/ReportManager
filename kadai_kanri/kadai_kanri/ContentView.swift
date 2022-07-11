//
//  ContentView.swift
//  kadai_kanri
//
//  Created by K.U on 2022/04/21.
//

import SwiftUI
import RealmSwift
import UIKit

extension Color {
    init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b)
    }
}


let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

struct ContentView: View {
    @State var tabSelection: Int = 0
    @State private var isAddTask: Bool = false
    
    init(){
        //タブの背景色
        UITabBar.appearance().backgroundColor = UIColor(red: 246/255, green: 239/255, blue: 231/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some View {
        
        TabView(selection: $tabSelection) {
            TimeTable(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("時間割")

                }.tag(0)
            TaskManagementView(tabSelection: $tabSelection) //realmオブジェクトを渡す
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("課題管理")
                }.tag(1)
            AddAssignment(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("課題追加")
                }.tag(2)
        }
        .accentColor(Color(hex: "D4DAD6"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
