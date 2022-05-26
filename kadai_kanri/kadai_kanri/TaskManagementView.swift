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
                        ForEach(0 ..< task.count) { id in
                            NavigationLink(destination: TaskDescriptionView(state: $isSelected), isActive: $isSelected) {
                                Button(action: {
                                    isSelected = true
                                })
                                {
                                    ZStack(alignment: .leading){
                                        Rectangle().fill(.gray)
                                        Text("""
                                            課題名:\(self.task[id])
                                            所要時間:テスト
                                            """)
                                    }
                                }
                                
                            }
                            .navigationBarHidden(true)
                        }
                        Spacer()
                    }
                    .listStyle(InsetListStyle())
                    
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
