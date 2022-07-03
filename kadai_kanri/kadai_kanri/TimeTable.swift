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
    @State private var isdsc: Bool = false
    @State private var showDeleteAlert: Bool = false //登録されていない科目を削除されそうな時に表示するアラート用
    
    var body: some View {
        let days: [String] = ["月", "火", "水", "木", "金"]
        let width: CGFloat = 55
        let height: CGFloat = 75
        
        NavigationView {
            ZStack {
                Color.light_beige.ignoresSafeArea() //背景色
                VStack {
                    
                    Spacer()
                    ZStack {
                        Color.beige
                        Text("時間割")
                            .font(.title)
                            .padding()
                    }
                    .frame(height: 80)
                    .border(.gray, width: 2)
                    
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
                        //曜日ごとにまとめて作りHStackで並べている
                        ForEach(days, id: \.self) {day in
                            VStack {
                                
                                ForEach((1...5), id: \.self){ pe in
                                    
                                    //つっら・・・ここのpeをstringで渡しただけで、（右のプレビューでは）特にエラーなく落ちてめっちゃ時間取られた・・・
                                    let filtering = NSPredicate(format: "dayOfWeek = %@ AND period = %@", argumentArray: ["\(day)",pe]) //フィルタリングの条件を作成（曜日と何限目か指定）
                                    let filtedList: Results<TimeTableElement> = timeTableElements.filter(filtering) //フィルタリング結果が入る？。結果は一件だけのはず！
                                    
                                    let presentText: String = filtedList.count != 0 ? filtedList[0].className : "" //結果があるときはフィルタリング結果の0番目、ないときは何も表示しない
                                    
                                    //実際にViewを作る
                                    NavigationLink(destination: ClassDescription(day: day, period: pe, state: $isdsc), isActive: $isdsc) { Button(action:{
                                        isdsc = true
                                    }) {
                                        TimeTableCell(width: width, height: height, className: presentText)
                                    } }
                                    .contextMenu(menuItems:
                                                    {
                                        //長押しして科目を削除できるようにする
                                        Button(action: {
                                            if filtedList.count == 0{
                                                self.showDeleteAlert = true
                                            }
                                            else{
                                                $timeTableElements.remove(filtedList[0])
                                            }
                                        })
                                        {
                                            Text("科目を削除する")
                                        }
                                        
                                    })
                                }
                            }
                        }
                    }
                    .alert("削除する科目はありません",isPresented: $showDeleteAlert,actions: {})
                    Spacer()
                    
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
                        .compositingGroup()        // Viewの要素をグループ化
                        .shadow(radius: 3, y: 5)
                    }
                    .navigationBarHidden(true)
                    
                    
                    Spacer()
                    Divider()
                        .background(Color(hex: "8C8C8C"))
                        .frame(height:2)
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
