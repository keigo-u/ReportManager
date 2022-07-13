//
//  ContentView.swift
//  sample
//
//  Created by kuniyoshi on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct pre_AddAssignment: View {
    init(tabSelection: Binding<Int>){
        UITableView.appearance().backgroundColor = .clear
        self._tabSelection = tabSelection
    }

    /*
     メモ：完全に気づかなかったんだけど・・・課題追加画面って経過時間を入力するようになっているから「終了した課題」を追加するわけなんですね・・・
     が、（現在は）課題管理画面で表示するのは、「終了していない課題」な訳なのですが、とりあえず！！「終了したもの」「終了していないもの」を考えないで、全部課題管理画面で表示するようにしておこう！
     */
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    let hours: [Int] = Array(0..<24)
    let minutes: [Int] = Array(0..<60)
    @State var SubjectName = "" //科目名
    @State var AssignmentName = "" //課題名
    @State var Time:[Int] = [0,0,0]
    @State var Remarks = ""
    @State var select = 0
    //@Binding var state :Bool
    @Binding var tabSelection: Int
    var body: some View {
        let width = UIScreen.main.bounds.size.width
        
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
                    
                    Form{
                        HStack{
                            Text("　科目名：").frame(width:CGFloat(width/3.5))
                            TextField("入力してください",text:$SubjectName);
                        }
                        HStack{
                            Text("　課題名：").frame(width:CGFloat(width/3.5))
                            TextField("入力してください",text:$AssignmentName)
                        }
                        HStack{
                            Text("経過時間：").frame(width:CGFloat(width/3.5))
                            Spacer()
                            TextField("\(Time[0])",value:$Time[0],formatter: NumberFormatter()).keyboardType(.numberPad)
                                .frame(width: CGFloat(width/8))
                            Text("　日")
                        }
                        HStack{
                            Spacer()
                            Picker("",selection: $Time[1]){
                                ForEach(0 ..< 24) { num1 in
                                    Text(String(self.hours[num1]))
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .clipped()
                            Text("時間")
                        }
                        HStack{
                            Spacer()
                            Picker("",selection: $Time[2]){
                                ForEach(0 ..< 60) { num2 in
                                    Text(String(self.minutes[num2]))
                                }
                            }
                            .clipped()
                            Text("　分")
                        }
                        HStack{
                            Text("　　備考：").frame(width:CGFloat(width/3.5))
                            TextField("入力してください",text:$Remarks)
                        }
                    }
                    .background(Color.light_beige)
                    
                    Spacer()
                    
                    Button(action:{
                        
                        //分に直す
                        let tmpTime = Time[0]*24*60 + Time[1]*60 + Time[2]
                        //realmに追加するAssignmentオブジェクトを作成する。期限は現在入力できるようになっていないため、Date()をとりあえず使っている。
                        let assignemtTemp = Assignment(assigmentName: AssignmentName,detail: Remarks,limitDate: Date(),duration: tmpTime,className: SubjectName)
                        //realmに追加する
                        addAssignmentToRealm(oneAssignment: assignemtTemp)
                        
                        //前の画面に戻る
                        //state = false
                        tabSelection = 1
                    }){
                        Text("課題を追加")
                            .padding()
                            .border(.black, width: 1)
                            .foregroundColor(.black)
                            .background(Color.light_green)
                    }
                    .frame(width: 200)
                    .compositingGroup()        // Viewの要素をグループ化
                    .shadow(radius: 3, y: 5)
                    
                    Spacer()
                    Divider()
                        .background(Color(hex: "8C8C8C"))
                        .frame(height:2)
                }
            }
            .navigationBarHidden(true)
        }
    }
    func addAssignmentToRealm(oneAssignment: Assignment){
        $assignments.append(oneAssignment)
    }
}
/*
struct pre_AddAssignment_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
