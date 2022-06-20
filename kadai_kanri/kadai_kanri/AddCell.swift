//
//  AddCell.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/19.
//

import SwiftUI
import RealmSwift

struct AddCell: View {
    
    @ObservedResults(TimeTableElement.self)  var timeTableElements
    
    @State var text: String = ""
    @State private var selectedIndex1 = 0
    @State private var selectedIndex2 = 0
    @State private var showDuplicateAlert : Bool = false //同じ曜日、時間に科目が入っていたらアラートを出す
    let days: [String] = ["月", "火", "水", "木", "金"]
    let time: [String] = ["１", "２", "３", "４", "５"]
    @Binding var state: Bool
    
    var body: some View {
        ScrollView {
            Text("時間割")
                .font(.title)
                .padding()
            VStack {
                RadioButton(selectedIndex: $selectedIndex1, axis: .horizontal, texts: days)
                RadioButton(selectedIndex: $selectedIndex2, axis: .horizontal, texts: time)
                HStack {
                    Text("科目名")
                    TextField("入力してください", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .alert("同じ時間に他の科目が追加されています",isPresented: $showDuplicateAlert,actions: {})//時間が被っていたらアラートを表示する
                Button(action: {
                    
                    //同じ位置に他の科目が入っていないか確認する
                    let filtering = NSPredicate(format: "dayOfWeek = %@ AND period = %@", argumentArray: ["\(days[selectedIndex1])",selectedIndex2 + 1]) //フィルタリングの条件を作成（曜日と何限目か指定）
                    let filtedList: Results<TimeTableElement> = timeTableElements.filter(filtering) //フィルタリング結果が入る
                    
                    showDuplicateAlert = filtedList.count == 0 ? false : true //結果が入っているときはアラートを表示しない。
                    
                    if showDuplicateAlert == false{
                        //追加するTimeTableElementオブジェクトを作成する
                        let added_element: TimeTableElement = TimeTableElement(dayOfWeek: days[selectedIndex1], period: selectedIndex2 + 1, className: text)
                        
                        //realmに追加する
                        $timeTableElements.append(added_element)
                        state = false
                    }
                })
                {
                    Text("追加")
                        .padding()
                        .foregroundColor(.black)
                }
            }
            .padding()
        }
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
        AddCell()
    }
}*/
