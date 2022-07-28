//
//  TimeTable.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct TimeTable: View {
    @Binding var tabSelection: Int
    @ObservedResults(TimeTableElement.self)  var timeTableElements
    
    @State private var isadd: Bool = false
    @State private var isdsc: Bool = false
    @State private var showDeleteAlert: Bool = false //登録されていない科目を削除されそうな時に表示するアラート用
    
    let userName:String 
    @State var dayOfWeek: String = ""
    @State var period: Int = 0
    
    var body: some View {
        let days: [String] = ["月", "火", "水", "木", "金"]
        let width: CGFloat = 55
        let height: CGFloat = 75
        let phone_width = UIScreen.main.bounds.size.width
        let phone_height = UIScreen.main.bounds.size.height
        let rate_width = phone_width/390
        let rate_height = phone_height/844
        
        NavigationView {
            ZStack {
                Color.light_beige.ignoresSafeArea() //背景色
                VStack {
                    ZStack {
                        Color.beige
                            .frame(height: 80*rate_height)
                            .border(.gray, width: 3)
                        Text("時間割")
                            .font(.title)
                            .padding()
                    }
                    .frame(height: 80*rate_height)
                    .offset(x: 0, y: -60*rate_height)
                    
                    //Spacer().frame(height:0)
                    
                    ScrollView{
                        HStack {
                            Text("")
                                .frame(width: 30*rate_width, height: 60*rate_width)
                                .background(Color.light_green)
                            ForEach(days, id: \.self) { day in
                                Text("\(day)")
                                    .frame(width: width*rate_width, height: 60*rate_width)
                                    .background(Color.light_green)
                            }
                        }
                        
                        HStack {
                            VStack {
                                ForEach((1...5), id: \.self) { index in
                                    Text("\(index)")
                                        .frame(width: 30*rate_width, height: height*rate_width)
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
                                        VStack {
                                            if filtedList.count != 0 { //科目があれば詳細を表示
                                                NavigationLink(destination: ClassDescription(day: $dayOfWeek, period: $period,state: $isdsc, userid:userName), isActive: $isdsc) { Button(action:{
                                                    isdsc = true
                                                    dayOfWeek = day
                                                    period = pe
                                                }) {
                                                    TimeTableCell(width: width*rate_width, height: height*rate_width, className: presentText)
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
                                            } else { //なければ新規追加
                                                NavigationLink(destination: AddCell(state: $isadd), isActive: $isadd) { Button(action:{
                                                    isadd = true
                                                }) {
                                                    TimeTableCell(width: width*rate_width, height: height*rate_width, className: presentText)
                                                } }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .alert("削除する科目はありません",isPresented: $showDeleteAlert,actions: {})
                    }
                    .offset(x: 0, y: -30*rate_height)
                    
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
                        .frame(width: 200*rate_width)
                        .compositingGroup()        // Viewの要素をグループ化
                        .shadow(radius: 3, y: 5)
                        
                    }
                    .navigationBarHidden(true)
                    Spacer()
                    Divider()
                        .background(Color(hex: "8C8C8C"))
                        .frame(height:2*rate_height)
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
