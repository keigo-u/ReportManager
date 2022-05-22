//
//  TaskManagementView.swift
//  timetable
//
//  Created by 當山寛人 on 2022/05/12.
//

import SwiftUI

struct TaskManagementView: View {

    let ScreenWidth = UIScreen.main.bounds.size.width
    
    private var task = ["めんどくさい課題","文字数が多すぎるスーパーめんどくさくさつらい課題","テスト課題","ああ課題","めんどくさい課題","文字数が多すぎるスーパーめんどくさくさつらい課題","テスト課題","ああ課題"]
    
    var body: some View {
        
        
        VStack{
            Text("課題管理")
                .padding()
                .font(.title)
            
            VStack{
                Text("現在出されている課題")
                    List{
                        ForEach(0 ..< task.count) { id in
                            
                            Button(action: {})
                            {
                                ZStack {
                                    Rectangle().fill(.gray)
                                    Text("課題名:\(self.task[id]) \n所要時間:テスト")
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 250, height: 350)
                    .listStyle(SidebarListStyle())
            }
                
            Button(action: {
                
            }) {
                Text("課題追加")
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.gray)
            }
        }
    }
}
