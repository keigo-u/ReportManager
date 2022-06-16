//
//  TimeTable.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/12.
//

import SwiftUI

struct TimeTable: View {
    @State var classes: [[String]] = [[" ","CS","情報処理","",""], ["DS","DS","中国語","CD","CD"], [" ","","","",""], ["","", "実験","実験","熱流体"], ["","", "中国語","DM",""]]
    @State private var isadd: Bool = false
    
    var body: some View {
        let days: [String] = ["月", "火", "水", "木", "金"]
        let width: CGFloat = 55
        let height: CGFloat = 75
        
        NavigationView {
            ZStack{
                Color.light_beige.ignoresSafeArea() //背景色
                VStack{
                    Spacer()
                    
                    Text("時間割")
                        .font(.title)
                        .padding()
                        .background(Color.beige)
                    Spacer()
                    HStack {
                        Text("")
                            .frame(width: 30, height: 60)
                            .background(Color.light_green)
                        ForEach(days, id: \.self) { day in
                            Text("\(day)")
                                .frame(width: width, height: 60)
                                .background(Color.light_green)
                        }
                    }
                    HStack {
                        VStack {
                            ForEach((1...5), id: \.self) { index in
                                Text("\(index)")
                                    .frame(width: 30, height: height)
                                    .background(Color.light_green)
                            }
                        }
                        ForEach((0...4), id: \.self) {i in
                            VStack {
                                ForEach((0...4), id: \.self) { j in
                                    
                                    NavigationLink(destination: AddCell(table: $classes, state: $isadd), isActive: $isadd) { Button(action:{
                                        isadd = true
                                    }) {
                                        TimeTableCell(width: width, height: height, className: classes[i][j])
                                    } }
                                    .navigationBarHidden(true)
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    NavigationLink(destination: AddCell(table: $classes, state: $isadd), isActive: $isadd) {
                        Button (action:{
                            isadd = true
                        }){
                            Text("科目を追加")
                                .padding()
                                .border(.black, width: 1)
                                .foregroundColor(.black)
                                .background(Color.light_green)
                        }
                        .frame(width: 200)
                    }
                    .navigationBarHidden(true)
                    
                    
                    Spacer()
                }
            }
        }
    }
}

struct TimeTableCell: View {
    var width: CGFloat
    var height: CGFloat
    var className: String
    
    var body: some View {
        Text(className)
            .frame(width: width, height: height)
            .foregroundColor(.black)
            .background(Color.light_green)
    }
}

struct TimeTable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
