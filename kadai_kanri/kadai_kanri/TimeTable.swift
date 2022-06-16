//
//  TimeTable.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct TimeTable: View {
    
    @ObservedResults(TimeTableElement.self)  var timeTableElements
    
    @State private var isadd: Bool = false
    
    var body: some View {
        let days: [String] = ["月", "火", "水", "木", "金"]
        let width: CGFloat = 55
        let height: CGFloat = 75
        ZStack{
            Color.light_beige.ignoresSafeArea() //背景色
            
            NavigationView {
                ScrollView {
                    Text("時間割")
                        .font(.title)
                        .padding()
                        .background(Color.beige)
                    
                    HStack{
                        Text("")
                            .frame(width: 30, height: height)
                        
                        //一番上の月火水木金を表示
                        ForEach(days, id: \.self) { day in
                            Text("\(day)")
                                .frame(width: width, height: height)
                                .border(.black, width: 1)
                                .background(Color.light_green)
                        }
                    }
                    
                    HStack {
                        VStack {
                            //左側の1,2,3,4,5を表示
                            ForEach((1...5), id: \.self) { index in
                                Text("\(index)")
                                    .frame(width: 30, height: height)
                                    .border(.black, width: 1)
                                    .background(Color.light_green)
                            }
                        }
                        //曜日ごとにまとめて作りHStackで並べている
                        ForEach(days, id: \.self) {day in
                            VStack {
                                
                                ForEach((1...5), id: \.self){ pe in
                                    
                                    //つっら・・・ここのpeをstringで渡しただけで、（右のプレビューでは）特にエラーなく落ちてめっちゃ時間取られた・・・
                                    let filtering = NSPredicate(format: "dayOfWeek = %@ AND period = %@", argumentArray: ["\(day)",pe]) //フィルタリングの条件を作成（曜日と何限目か指定）
                                    let filtedList: Results<TimeTableElement> = timeTableElements.filter(filtering) //フィルタリング結果が入る？。結果は一件だけのはず！
                                    
                                    let presentText: String = filtedList.count != 0 ? filtedList[0].className : ""
                                    
                                    //実際にViewを作る
                                    NavigationLink(destination: AddCell(state: $isadd), isActive: $isadd) { Button(action:{
                                        isadd = true
                                    }) {
                                        TimeTableCell(width: width, height: height, className: presentText)
                                    } }
                                    
                                }
                            }
    
                        }
                        Spacer()
                        
                        
                    }
                    
                    NavigationLink(destination: AddCell(state: $isadd), isActive: $isadd) {
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
