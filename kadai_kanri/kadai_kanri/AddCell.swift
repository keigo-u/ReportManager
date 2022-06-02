//
//  AddCell.swift
//  kadai_kanri
//
//  Created by K.U on 2022/05/19.
//

import SwiftUI

struct AddCell: View {
    @State var text: String = ""
    @State private var selectedIndex1 = 0
    @State private var selectedIndex2 = 0
    let days: [String] = ["月", "火", "水", "木", "金"]
    let time: [String] = ["1", "2", "3", "4", "5"]
    @Binding var table: [[String]]
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
                Button(action: {
                    table[selectedIndex1][selectedIndex2] = text
                    state = false
                }) {
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