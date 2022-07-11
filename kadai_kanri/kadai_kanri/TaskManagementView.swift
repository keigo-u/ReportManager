//
//  TaskManagementView.swift
//  timetable
//
//  Created by 當山寛人 on 2022/05/12.
//

import SwiftUI
import RealmSwift

struct TaskManagementView: View {
    @Binding var tabSelection: Int
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    @ObservedResults(TimeTableElement.self)  var timeTableElements//時間割一コマのリスト
    
    @State private var isSelected: Bool = false
    @State private var isAddTask: Bool = false
    
    @State private var isFinished = false //終了済みの課題を表示するかどうかにつかう。trueなら完了した課題を表示
    
    @State private var isShowFinishPopUP = false //課題を終了したときのポップアップを表示するかの判定に使う
    
    @State private var isShowDeletePopUP = false //課題を削除する時のポップアップを表示するかの判定に使う
    
    @State private var nowSelectedAssighment: Assignment = Assignment(assigmentName: "placeholder", detail: "placeholder", limitDate: Date(), duration: 0, className: "placeholder") //タップされた課題を入れる（課題の削除や、編集で使う）初期値はとりあえずで入れたもの意味はない。
    
    @State private var comment: String = ""
    
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        ZStack{
            NavigationView {
                ZStack{
                    Color.light_beige.ignoresSafeArea()
                    VStack{
                        ZStack {
                            Color.beige
                            Text("課題管理")
                                .padding()
                                .font(.title)
                        }
                        .frame(height: 80)
                        .border(.gray, width: 3)
                        .padding(.top, 15)
                        
                        Spacer()
                        
                        VStack{
                            Picker(selection: $isFinished, label: Text("実行状態")) {
                                Text("実行中")
                                    .tag(false)
                                Text("完了済み")
                                    .tag(true)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                            .background(Color.beige)
                            
                            VStack {
                                //assignmentは予約語だったという・・・
                                ForEach(assignments) { oneAssignment in

                                    if oneAssignment.isFinished == isFinished{
                                        //タスク詳細画面を呼び出す
                                        HStack{
                                            NavigationLink(destination: TaskDescriptionView(selectedAssignment: oneAssignment, state: $isSelected)) {
                                                let timeDay = (oneAssignment.duration/1440)
                                                let timeHour = (oneAssignment.duration%1440)/60
                                                let timeMinute = oneAssignment.duration%60
                                                
                                                //期限をDate型からString型へ
                                                let calender = Calendar(identifier: .gregorian)
                                                let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: oneAssignment.limitDate)
                                                let limitDateSet: String = "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!) \(dateComponents.hour!):\(dateComponents.minute!)"
                                                
                                                VStack {
                                                    Text("科目名: \(oneAssignment.className)")
                                                        .foregroundColor(Color.black)
                                                    Text("課題名: \(oneAssignment.assignmentName)")
                                                        .foregroundColor(Color.black)
                                                    Text("期限: \(limitDateSet)")
                                                        .foregroundColor(Color.black)
                                                    if oneAssignment.isFinished != isFinished {
                                                        Text("所要時間:\(timeDay)日\(timeHour)時間\(timeMinute)分")
                                                            .foregroundColor(Color.black)
                                                    }
                                                }
                                            }
                                            
                                            //左のチェックマークとゴミ箱
                                            VStack{
                                                //チェックボックス、タップすると完了済みに移動
                                                Image(systemName: oneAssignment.isFinished ? "checkmark.square.fill" : "checkmark.square")
                                                    .onTapGesture(count: 1){
                                                        
                                                        //ポップアップを表示する（値の変更はポップアップのviewで行う）
                                                        if oneAssignment.isFinished == false{
                                                            isShowFinishPopUP = true
                                                            nowSelectedAssighment = oneAssignment
                                                        }else{
                                                            //課題のisFinishedを置き換える(「完了済み」に入った課題を「実行中」に戻すためを想定)
                                                            let realm = try! Realm()
                                                            let finishedAssignment = oneAssignment.thaw()!
                                                            try! realm.write {
                                                                finishedAssignment.isFinished = finishedAssignment.isFinished ? false : true
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                
                                                //ゴミ箱、タップすると削除される
                                                Button(action: {
                                                    isShowDeletePopUP.toggle()
                                                    
                                                }) {
                                                    Image(systemName: "trash.fill")
                                                        .foregroundColor(Color.gray)
                                                }
                                                .alert(isPresented: $isShowDeletePopUP) {
                                                    Alert(title: Text("この課題を削除しますか？"), primaryButton: .cancel(Text("キャンセル")), secondaryButton: .destructive(Text("削除"), action: {
                                                        let realm = try! Realm()
                                                        let deletedAssignment = oneAssignment.thaw()!
                                                        try! realm.write {
                                                            realm.delete(deletedAssignment)
                                                        }
                                                    }))
                                                }
                                            }
                                        }
                                        .padding()
                                        .frame(width: screenWidth - 80)
                                        .background(Color.light_beige)
                                        .compositingGroup()        // Viewの要素をグループ化
                                        .shadow(radius: 3, y: 5)
                                    }
                                }
                            }
                            .padding()
                            .frame(width: screenWidth - 40)
                            .background(Color.light_green)
                            
                            Spacer()
                        }
                        .background(Color.light_green)
                        .frame(width: screenWidth - 40)
                        
                        Spacer()
                        
                        Divider()
                            .background(Color(hex: "8C8C8C"))
                            .frame(height:2)
                    }
                    .frame(maxWidth: .infinity)
                }
                .navigationBarHidden(true)
            }
            
            if isShowFinishPopUP {
                //色を重ねることによって画面を暗くする
                Rectangle()
                    .fill(Color.black)
                    .frame(width:CGFloat(screenWidth), height: CGFloat(screenHeight) + 50)
                    .opacity(0.3)
            }
            
            //終了タスクポップアップ表示用
            if isShowFinishPopUP{
                finishPopUpView(isShowFinishPopUP: $isShowFinishPopUP,nowSelectedAssignment: nowSelectedAssighment)
            }
        }
    }
}

struct TaskManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//課題を終了したときに出てくるポップアップ。値の置き換えもここで行う
struct finishPopUpView: View{
    @State private var inputTime:Int  = 0//入力された課題に取り組んだ時間
    @State private var inputComment: String = ""//入力されたコメント
    
    @Binding var isShowFinishPopUP: Bool //ポップアップを表示するかの判定用
    var nowSelectedAssignment: Assignment //現在選択されている課題
    var body: some View{
        
        
        VStack{
            Text("課題に取り組んだ時間とコメントを入力してください")
            
            //取り組んだ時間入力用
            HStack{
                VStack{
                    Image(systemName: "clock.badge.checkmark")
                    Text("Time")
                }
                
                TextField("",value: $inputTime,formatter: NumberFormatter())
                
                Text("分")
            }
            
            //コメント入力用
            HStack{
                VStack{
                    Image(systemName: "person.wave.2.fill")
                    Text("Comment")
                }
                
                TextField("",text: $inputComment)
            }
            
            Divider()
            
            //ボタン
            HStack{
                Button(action: {
                    //ポップアップを閉じる
                    isShowFinishPopUP.toggle()
                }){
                    Text("キャンセル")
                }
                
                Button(action: {
                    
                    //課題のisFinishedを置き換える
                    let realm = try! Realm()
                    let finishedAssignment = nowSelectedAssignment.thaw()!
                    try! realm.write {
                        //所要時間、コメントの追加、完了状態の変更を行う
                        finishedAssignment.duration = inputTime
                        finishedAssignment.detail = inputComment
                        finishedAssignment.isFinished = finishedAssignment.isFinished ? false : true
                    }
                    
                    //ポップアップを閉じる
                    isShowFinishPopUP.toggle()
                }){
                    Text("OK")
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}
