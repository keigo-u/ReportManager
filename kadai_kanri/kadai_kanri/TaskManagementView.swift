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

//    private var task = ["めんどくさい課題","文字数が多すぎるスーパーめんどくさくさつらい課題","テスト課題","ああ課題","めんどくさい課題","文字数が多すぎるスーパーめんどくさくさつらい課題","テスト課題","ああ課題"]
    @State private var isSelected: Bool = false
    @State private var isAddTask: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("課題管理")
                    .padding()
                    .font(.title)
                
                VStack{
                    Text("現在出されている課題")
                    
                    
                    List{
                        //assignmentは予約語だったという・・・
                        ForEach(assignments) { oneAssignment in
                            //タスク詳細画面を呼び出す
                            TaskRow(oneAssignment: oneAssignment, isSelected: $isSelected)

                        }
                        Spacer()
                    }
                    .listStyle(InsetListStyle())
                    
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
    }
}
