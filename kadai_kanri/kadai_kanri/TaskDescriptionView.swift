//
//  TaskDescriptionView.swift
//  timetable
//
//  Created by 當山寛人 on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct TaskDescriptionView: View {
    /*
     タスク詳細画面は、「あるタスク」を終了するのにかかる時間や、その感想などを表示する箇所である
     が、現在ローカルでのみ動作するので、本来ここで表示する「みんな」のタスクにかかる時間などを表示することができない
     ので、
     @persisted(Assignment.self)をselectedAssignemtの名前（もしくはid?）でフィルターしたものを表示するようにしたい。(なんとなくそっちの方が後から楽そう)
     */
    @Environment(\.presentationMode) var presentationMode //戻るボタンを作るために作成
    
    @State var sumDuration: Int = 0
    
    
    var selectedAssignment: Assignment //選択されたタスク
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    
//
//    var nameList = ["A","B","C","D"]
//    var notesList = ["めんどくさすぎ","かんたん","easy","hard"]
//
    @Binding var state :Bool
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        
        let filtering = NSPredicate(format: "assignmentName = %@ AND className = %@ AND isFinished = %@", argumentArray: ["\(selectedAssignment.assignmentName)","\(selectedAssignment.className)",true]) //フィルタリングの条件を作成（選択された課題名と等しい課題を指定）
        let filtedList: Results<Assignment> = assignments.filter(filtering) //フィルタリング結果が入る？
        
        
        let averageTime: Double = filtedList.average(ofProperty: "duration") ?? 0
        
        
        
        VStack {
            Text("課題詳細")
                .font(.largeTitle)
            
            
                let timeDay = String(format: "%.1f",(averageTime/1440))
                let timeHour = String(format: "%.1f",(averageTime.truncatingRemainder(dividingBy: 1440))/60)
                let timeMinute = String(format: "%.1f",averageTime.truncatingRemainder(dividingBy: 60))
                Text("平均所要時間:約\(timeDay)日\(timeHour)時間\(timeMinute)分")
            
            Text("要素の名前:\(selectedAssignment.assignmentName)")
            
            List{
                ForEach(filtedList) { element in
                    ZStack(alignment: .leading) {
                        let timeDay = (element.duration/1440)
                        let timeHour = (element.duration%1440)/60
                        let timeMinute = element.duration%60
                        Rectangle().fill(.gray)
                        Text("""
                             \(element.userName)さん
                             所要時間:\(timeDay)日\(timeHour)時間\(timeMinute)分
                             備考:\(element.detail)
                             """)
                            .padding()
                    }
                    
                }
                Spacer()
            }
            .frame(width: 250, height: 350)
            .listStyle(SidebarListStyle())
            
            Button(action: {
                dismiss()
            }){
                Text("戻る")
                    .font(.largeTitle)
                    .frame(width: 150, height: 60)
                    .foregroundColor(Color.black)
                    .background(Color.gray)
            }
        }
    }
    
    
    
}
/*
struct TaskDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDescriptionView()
    }
}*/

