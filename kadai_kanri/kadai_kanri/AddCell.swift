//
//  AddCell.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/19.
//

import SwiftUI
import RealmSwift
import KeyboardObserving

struct AddCell: View {
    
    @ObservedResults(TimeTableElement.self)  var timeTableElements
    
    @State var text: String = "" //科目名
    @State var teacher: String = "" //教員名
    @State var place: String = "" //場所
    @State private var selectedIndex1 = 0
    @State private var selectedIndex2 = 0
    @State private var showDuplicateAlert : Bool = false //同じ曜日、時間に科目が入っていたらアラートを出す
    let days: [String] = ["月", "火", "水", "木", "金"]
    let time: [String] = ["１", "２", "３", "４", "５"]
        
    @Binding var state: Bool
    
    var body: some View {
        
        let phone_width = UIScreen.main.bounds.size.width
        let phone_height = UIScreen.main.bounds.size.height
        let rate_width = phone_width/390
        let rate_height = phone_height/844
        
        ZStack {
            Color.light_beige.ignoresSafeArea()
            VStack {
                ZStack {
                    Color.beige
                        .frame(height: 80*rate_height)
                        .border(.gray, width: 3)
                    Text("科目追加")
                    
                        .padding()
                        .font(.title)
                }
                .frame(height: 80*rate_height)
                .offset(x: 0, y: -60*rate_height)


                ScrollView{
                    VStack{
                        VStack {
                            Text("検索")
                                .padding(.top, 10)
                            VStack {
                                RadioButton(selectedIndex: $selectedIndex1, axis: .horizontal, texts: days)
                                RadioButton(selectedIndex: $selectedIndex2, axis: .horizontal, texts: time)
                                HStack {
                                    Text("科目名")
                                    TextField("入力してください", text: $text)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                .alert("同じ時間に他の科目が追加されています",isPresented: $showDuplicateAlert,actions: {})//時間が被っていたらアラートを表示する
                            }
                            .padding()
                            .background(Color.light_green)
                        }
                        .background(Color.beige)
                        .padding()
                        
                        VStack {
                            Text("詳細入力")
                                .padding(.top, 10)
                            VStack {
                                Text("科目の詳細を入力してください")
                                VStack {
                                    HStack {
                                        VStack {
                                            Image(systemName: "person.fill")
                                            Text("担当教員")
                                        }
                                        TextField("(入力)", text: $teacher)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }
                                    HStack {
                                        VStack {
                                            Image(systemName: "paperplane.fill")
                                            Text("場所")
                                        }
                                        TextField("(入力)", text: $place)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }
                                }
                            }
                            .padding()
                            .background(Color.light_green)
                        }
                        .background(Color.beige)
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            //同じ位置に他の科目が入っていないか確認する
                            let filtering = NSPredicate(format: "dayOfWeek = %@ AND period = %@", argumentArray: ["\(days[selectedIndex1])",selectedIndex2 + 1]) //フィルタリングの条件を作成（曜日と何限目か指定）
                            let filtedList: Results<TimeTableElement> = timeTableElements.filter(filtering) //フィルタリング結果が入る
                            
                            showDuplicateAlert = filtedList.count == 0 ? false : true //結果が入っているときはアラートを表示しない。
                            
                            if showDuplicateAlert == false{
                                //追加するTimeTableElementオブジェクトを作成する
                                let added_element: TimeTableElement = TimeTableElement(dayOfWeek: days[selectedIndex1], period: selectedIndex2 + 1, className: text, teacher:teacher, place:place)
                                
                                //realmに追加する
                                $timeTableElements.append(added_element)
                                state = false
                            }
                        }){
                            Text("追加　　　")
                                .padding()
                                .border(.black, width: 1)
                                .foregroundColor(.black)
                                .background(Color.light_green)
                        }
                        .frame(width: 200*rate_width)
                        .compositingGroup()        // Viewの要素をグループ化
                        .shadow(radius: 3, y: 5)
                    }
                    
                }
                .offset(x: 0, y: -30*rate_height)
                

                
                Button (action:{
                    state = false
                }){
                    Text("戻る　　　")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.light_gray)
                }
                .frame(width: 200*rate_width)
                .compositingGroup()        // Viewの要素をグループ化
                .shadow(radius: 3, y: 5)
                
                Spacer()
                Divider()
                    .background(Color(hex: "8C8C8C"))
                    .frame(height:2*rate_height)
            }
        }
        .navigationBarHidden(true)
    }
}

struct Item {
    var isChecked: Bool
    var name: String
    
    init(_ name: String) {
        self.isChecked = false
        self.name = name
    }
}

/*
struct AddCell_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
