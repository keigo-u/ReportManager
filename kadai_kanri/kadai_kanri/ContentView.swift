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
    @State private var isAddTask: Bool = false
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(red: 140, green: 140, blue: 140, alpha: 1) //タブの背景色を指定
    }
    var body: some View {
        
        TabView {
            TimeTable()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("時間割")

                }
            TaskManagementView() //realmオブジェクトを渡す
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("課題管理")
                }
            AddAssignment(state: $isAddTask)
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("課題追加")
                }
        }
        .onAppear {
            //タブの上の線を表示するのに必要らしい？
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
                
            }
        }
        .accentColor(Color(hex: "D4DAD6"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
