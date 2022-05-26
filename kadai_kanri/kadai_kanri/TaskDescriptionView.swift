//
//  TaskDescriptionView.swift
//  timetable
//
//  Created by 當山寛人 on 2022/05/12.
//

import SwiftUI

struct TaskDescriptionView: View {
    var averageTime = 90
    var nameList = ["A","B","C","D"]
    var notesList = ["めんどくさすぎ","かんたん","easy","hard"]
    @Binding var state :Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("課題詳細")
                .font(.largeTitle)
            
            Text("平均所要時間\(averageTime)分")
            
            List{
                ForEach(0 ..< nameList.count) { id in
                    
                    ZStack(alignment: .leading) {
                        Rectangle().fill(.gray)
                        Text("""
                             \(nameList[id])さん
                             所要時間:\(averageTime)
                             備考:\(notesList[id])
                             """)
                            .padding()
                    }
                    
                }
                Spacer()
            }
            .frame(width: 250, height: 350)
            .listStyle(SidebarListStyle())
            
            Button(action: {
                state = false
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
