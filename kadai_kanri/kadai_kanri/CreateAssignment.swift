//
//  CreateAssignment.swift
//  kadai_kanri
//
//  Created by K.U on 2022/07/07.
//

import SwiftUI
import RealmSwift

struct CreateAssignment: View {
    
    let screenWidth = UIScreen.main.bounds.size.width //スクリーン幅
    @ObservedResults(TimeTableElement.self)  var timeTableElements //時間割データ
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    
    @Binding var state: Bool
    @Binding var selectedClass: String //科目名
    @State private var AssignmentName: String = "" //課題名
    @State private var detail: String = "" //課題詳細
    @State private var selectionDate = Date()
    
    let userid :String
    var body: some View {
        NavigationView{
            ZStack {
                Color.light_beige.ignoresSafeArea()
                VStack {
                    ZStack {
                        Color.beige
                        Text("課題追加")
                            .font(.title)
                            .padding()
                    }
                    .frame(height: 80)
                    .border(.gray, width: 3)
                    .padding(.top, 15)
                    
                    Spacer()
                    
                    VStack {
                        HStack(spacing: 10) {
                            Text("科目名:")
                            Picker(selection: $selectedClass, label:  Text("科目名")) {
                                ForEach(timeTableElements) { cell in
                                    Text("\(cell.className)").tag(cell.className)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .colorMultiply(Color.black)
                            .foregroundColor(Color.black)
                            .labelsHidden()
                            .padding(5)
                            .padding(.leading, 35)
                            .padding(.trailing, 35)
                            .border(Color.gray, width: 1)
                        }
                        .padding()
                        .frame(width: screenWidth - 40, alignment: .leading)
                        
                        HStack {
                            Text("課題名:")
                            TextField("", text: $AssignmentName)
                                .padding(5)
                                .border(Color.gray, width: 1)
                        }
                        .padding()
                        .frame(width: screenWidth - 40, alignment: .leading)
                        
                        HStack {
                            Text("期限:")
                            DatePicker("期限", selection: $selectionDate)
                                .labelsHidden()
                                .colorMultiply(Color.black)
                        }
                        .padding()
                        .frame(width: screenWidth - 40, alignment: .leading)
                        
                        HStack {
                            Text("課題詳細:")
                            TextField("", text: $detail)
                                .padding(5)
                                .border(Color.gray, width: 1)
                        }
                        .padding()
                        .frame(width: screenWidth - 40, alignment: .leading)
                        
                        Button(action:{
                            let assignemtTemp = Assignment(assigmentName: AssignmentName,detail: detail, limitDate: selectionDate,duration: 0,className: selectedClass) //realmに追加するAssignmentオブジェクトを作成
                            assignemtTemp.userName = userid
                            
                            
                            //追加する
                            let user = realmApp.currentUser!
                            let realm = try! Realm(configuration: user.configuration(partitionValue: "allAssignment"))
                            try! realm.write {
                                realm.add(assignemtTemp)
                            }
                            
                            state = false //前の画面に戻る
                        }){
                            Text("課題を追加")
                                .padding()
                                .border(.black, width: 1)
                                .foregroundColor(.black)
                                .background(Color.light_green)
                        }
                        .padding()
                        .frame(width: 200)
                        .compositingGroup()        // Viewの要素をグループ化
                        .shadow(radius: 3, y: 5)
                    }
                    .background(Color.light_green)
                    .padding()
                    .frame(width: screenWidth - 40)
                    
                    Spacer()
                    
                    Button(action: {
                        state = false
                    }) {
                        Text("戻る　　　")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.light_gray)
                    }
                    .padding()
                    .compositingGroup()        // Viewの要素をグループ化
                    .shadow(radius: 3, y: 5)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CreateAssignment_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

