//
//  AddAssignment.swift
//  kadai_kanri
//
//  Created by K.U on 2022/07/07.
//

import SwiftUI
import RealmSwift

struct AddAssignment: View {
    init(tabSelection: Binding<Int>,userid: String,state: Binding<Bool>) {
        self._tabSelection = tabSelection
        UITableView.appearance().backgroundColor = .clear
        self.userid = userid
        self._state = state
    }
    @Binding var tabSelection: Int //tabカウンタ
    
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    
    @ObservedResults(TimeTableElement.self)  var timeTableElements //時間割のリスト
    
    let userid :String
    @Binding var state: Bool
    
    @State var selectedClass: String = ""
    @State var isSelected: Bool = false //課題詳細用
    @State var isadd: Bool = false //課題作成用
    @State var assignmentFilter = NSPredicate(format: "className == %@", "") //課題用フィルター
    

    var body: some View {
        NavigationView {
            ZStack {
                Color.light_beige.ignoresSafeArea()
                VStack{
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
                    
                    HStack(spacing: 40) {
                        Text("科目名を選択")
                        Picker(selection: $selectedClass, label:  Text("科目名")) {
                            ForEach(timeTableElements) { cell in
                                Text("\(cell.className)").foregroundColor(Color.black)
                                    .tag(cell.className)
                            }
                        }
                        .onChange(of: selectedClass) { tmpClass in
                            assignmentFilter = NSPredicate(format: "className == %@" , tmpClass)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .colorMultiply(Color.black)
                        //.labelsHidden()
                        .padding(5)
                        .padding(.leading, 35)
                        .padding(.trailing, 35)
                        .border(Color.gray, width: 1)
                    }
                    .padding()
                    .frame(width: screenWidth - 40, height: 50, alignment: .leading)
                    .background(Color.light_green)
                    
                    Spacer()
                    
                    VStack {
                        Text("出されている課題")
                            .padding(.top, 10)
                        ScrollView {
                            
                            
                            let user = realmApp.currentUser!
                            let assignments = try! Realm(configuration: user.configuration(partitionValue: "allAssignment")).objects(Assignment.self).filter(assignmentFilter)
                            if assignments.count != 0 {
                                ForEach(assignments) { oneAssignment in
                                    HStack {
                                        Text(oneAssignment.assignmentName)
                                            .frame(alignment: .leading)
                                        Button("追加", action: {})
                                            .foregroundColor(Color.black)
                                            .padding(5)
                                            .border(Color.black, width: 1)
                                            .frame(alignment: .trailing)
                                    }
                                    .padding()
                                    .frame(width: screenWidth - 80)
                                    .background(Color.light_beige)
                                    .compositingGroup()        // Viewの要素をグループ化
                                    .shadow(radius: 3, y: 5)
                                }
                            } else {
                                Text("    ")
                                    .padding()
                            }
                        }
                        .padding()
                        .frame(width: screenWidth - 40)
                        .background(Color.light_green)
                    }
                    .frame(width: screenWidth - 40)
                    .background(Color.beige)
                    
                    Spacer()
                    
                    VStack {
                        Text("追加したい課題が一覧にない場合")
                            .padding(.top, 10)
                        VStack {
                            NavigationLink(destination: CreateAssignment(state: $isadd, selectedClass: selectedClass,userid:userid), isActive: $isadd) {
                                Button (action:{
                                    isadd = true
                                }){
                                    Text("新たに課題を追加")
                                        .padding()
                                        .border(.black, width: 1)
                                        .foregroundColor(.black)
                                        .background(Color.light_beige)
                                }
                                .compositingGroup()        // Viewの要素をグループ化
                                .shadow(radius: 3, y: 5)
                            }
                        }
                        .padding()
                        .frame(width: screenWidth - 40)
                        .background(Color.light_green)
                    }
                    .frame(width: screenWidth - 40)
                    .background(Color.beige)
                    

                    Spacer()

                    
                    Divider()
                        .background(Color(hex: "8C8C8C"))
                        .frame(height:2)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
//
//struct AddAssignment_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
