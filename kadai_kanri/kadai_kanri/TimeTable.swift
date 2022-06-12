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
    
    @State var classes: [[String]] = [[" ","CS","情報処理","",""], ["DS","DS","中国語","CD","CD"], [" ","","","",""], ["","", "実験","実験","熱流体"], ["","", "中国語","DM",""]]
    @State private var isadd: Bool = false
    
    var body: some View {
        let days: [String] = ["月", "火", "水", "木", "金"]
        let width: CGFloat = 50
        let height: CGFloat = 50
        
        NavigationView {
            ScrollView {
                Text("時間割")
                    .font(.title)
                    .padding()
                HStack {
                    Text("")
                        .frame(width: 30, height: height)
                    //一番上の月火水木金を表示
                    ForEach(days, id: \.self) { day in
                        Text("\(day)")
                            .frame(width: width, height: height)
                            .border(.black, width: 1)
                            .background(Color.gray)
                    }
                }
                HStack {
                    VStack {
                        //左側の1,2,3,4,5を表示
                        ForEach((1...5), id: \.self) { index in
                            Text("\(index)")
                                .frame(width: 30, height: height)
                                .border(.black, width: 1)
                                .background(Color.gray)
                        }
                    }
                    //曜日ごとにまとめて作りHStackで並べている
                    ForEach(days, id: \.self) {day in
                        VStack {
                            //                            ForEach((0...4), id: \.self) { j in
                            //
                            //                                NavigationLink(destination: AddCell(table: $classes, state: $isadd), isActive: $isadd) { Button(action:{
                            //                                    isadd = true
                            //                                }) {
                            //                                    TimeTableCell(width: width, height: height, className: classes[i][j])
                            //                                } }
                            //                            }
                            ForEach((1...5), id: \.self){ pe in
                                
                                //つっら・・・ここのpeをstringで渡しただけで、（右のプレビューでは）特にエラーなく落ちてめっちゃ時間取られた・・・
                                let filtering = NSPredicate(format: "dayOfWeek = %@ AND period = %@", argumentArray: ["\(day)",pe]) //フィルタリングの条件を作成（曜日と何限目か指定）
                                let filtedList: Results<TimeTableElement> = timeTableElements.filter(filtering) //フィルタリング結果が入る？。結果は一件だけのはず！
                                
                                let presentText: String = filtedList.count != 0 ? filtedList[0].className : ""
                                
                                //実際にViewを作る
                                NavigationLink(destination: AddCell(table: $classes, state: $isadd), isActive: $isadd) { Button(action:{
                                    isadd = true
                                }) {
                                    TimeTableCell(width: width, height: height, className: presentText)
                                } }
                                
                            }
                        }
                    }
                }
                
                NavigationLink(destination: AddCell(table: $classes, state: $isadd), isActive: $isadd) {
                    if #available(iOS 15.0, *) {
                        Button (action:{
                            isadd = true
                        }){
                            Text("科目を追加する")
                                .padding()
                                .foregroundColor(.black)
                        }
                        .padding()
                        .buttonStyle(.bordered)
                    } else {
                        // Fallback on earlier versions
                        Button (action:{
                            isadd = true
                        }){
                            Text("科目を追加する")
                                .padding()
                                .border(.black, width: 1)
                                .foregroundColor(.black)
                                .background(Color.gray)
                        }
                    }
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
            .border(.black, width: 1)
            .foregroundColor(.black)
    }
}

struct TimeTable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
