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
        

        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
                        
        let filtering = NSPredicate(format: "assignmentName = %@ AND className = %@ AND isFinished = %@", argumentArray: ["\(selectedAssignment.assignmentName)","\(selectedAssignment.className)",true]) //フィルタリングの条件を作成（選択された課題名と等しい課題を指定）
        let filtedList: Results<Assignment> = assignments.filter(filtering) //フィルタリング結果が入る？
        let averageTime: Double = filtedList.average(ofProperty: "duration") ?? 0 //平均時間(分)
                        
        
        //期限をDate型からString型へ
        let calender = Calendar(identifier: .gregorian)
        let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: selectedAssignment.limitDate)
        let limitDateSet: String = "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!) \(dateComponents.hour!):\(dateComponents.minute!)"
        
        ZStack {
            Color.light_beige.ignoresSafeArea()
            VStack {
                ZStack {
                    Color.beige
                    Text("課題詳細")
                        .font(.title)
                        .padding()
                }
                .frame(height: 80)
                .border(.gray, width: 3)
                .padding(.top, 15)
                
                Spacer()
                
                VStack {
                    Text("科目名: \(selectedAssignment.className)")
                    Divider()
                    Text("課題名: \(selectedAssignment.assignmentName)")
                    Divider()
                    Text("期限: \(limitDateSet)")
                    Divider()
                    Text("平均所要時間: \(averageTime)分")
                }
                .padding()
                .frame(width: screenWidth-80, alignment: .leading)
                .background(Color.beige)
                
                ScrollView {
                    ForEach(filtedList) { element in
                        VStack {
                            Text("\(element.userName)さん")
                            Divider()
                            Text("所要時間:\(element.duration)")
                            Divider()
                            Text("備考:\(element.detail)")
                        }
                        .padding(5)
                        .background(Color.light_beige)
                    }
                    .border(Color.gray, width:1)
                    
                    Spacer()
                }
                .padding()
                .background(Color.light_green)
                .frame(width: screenWidth-40)
                
                Button(action: {
                    dismiss()
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
            .navigationBarHidden(true)
        }
    }
    
    
    
}

struct TaskDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

