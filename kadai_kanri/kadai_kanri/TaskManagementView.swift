//
//  TaskManagementView.swift
//  timetable
//
//  Created by 當山寛人 on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct TaskManagementView: View {
    
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    @ObservedResults(TimeTableElement.self)  var timeTableElements//時間割一コマのリスト

    @State private var isSelected: Bool = false
    @State private var isAddTask: Bool = false
    
    @State private var isFinished = false //終了済みの課題を表示するかどうかにつかう。trueなら完了した課題を表示
    
    var body: some View {
        let bounds = UIScreen.main.bounds
        let screenWidth = Int(bounds.width)
        let screenHeight = Int(bounds.height)
        
        NavigationView {
            ZStack{
                Color.light_beige.ignoresSafeArea()
                VStack{
                    Text("課題管理")
                        .padding()
                        .font(.title)
                    
                    VStack{
                        HStack{
                            Button(action: {
                                isFinished = false
                            }){
                                Text("実行中")
                            }
                            .padding(.trailing, 20)
                            .foregroundColor(.black)
                            Button(action: {
                                isFinished = true
                            }){
                                Text("完了済み")
                            }
                            .padding(.leading, 20)
                            .foregroundColor(.black)
                        }
                        .frame(width: CGFloat(screenWidth) - 40, height: 30)
                    
                    
                    List{
                        //assignmentは予約語だったという・・・
                        ForEach(assignments) { oneAssignment in
                            if oneAssignment.isFinished == isFinished{
                            //タスク詳細画面を呼び出す
                            TaskRow(oneAssignment: oneAssignment, isSelected: $isSelected)
                            }

                        }
                    }
                        .listStyle(InsetListStyle())
                        .frame(width: CGFloat(screenWidth)-40)
                        
                        
                        //課題追加画面を呼び出す
                        NavigationLink(destination: AddAssignment(state: $isAddTask), isActive: $isAddTask) {
                            if #available(iOS 15.0, *) {
                                Button (action:{
                                    isAddTask = true
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
                                    isAddTask = true
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
    }
}

struct TaskManagementView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagementView()
    }
}

//課題の行一つ分のView
struct TaskRow: View{
    var oneAssignment: Assignment
    @Binding var isSelected: Bool
    
    var body: some View{
        HStack{
        NavigationLink(destination: TaskDescriptionView(selectedAssignment: oneAssignment, state: $isSelected)) {
            ZStack(alignment: .leading){
                Rectangle().fill(.gray)
                let timeDay = (oneAssignment.duration/1440)
                let timeHour = (oneAssignment.duration%1440)/60
                let timeMinute = oneAssignment.duration%60
                Text("""
                    課題名:\(oneAssignment.assignmentName)
                    所要時間:\(timeDay)日\(timeHour)時間\(timeMinute)分
                    """)
            }
            
        }
        .navigationBarHidden(true)
            
            Image(systemName: oneAssignment.isFinished ? "checkmark.square.fill" : "checkmark.square")
                .onTapGesture(count: 1){
                    
                let realm = try! Realm()
                let finishedAssignment = oneAssignment.thaw()!
                try! realm.write {
                    finishedAssignment.isFinished = finishedAssignment.isFinished ? false : true
                }
                
                
            }
        }
    }
}
