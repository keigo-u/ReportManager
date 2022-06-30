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
    
    @State private var isShowFinishPopUP = false //課題を終了したときのポップアップを表示するかの判定に使う
    
    @State private var isShowDeletePopUP = false //課題を削除する時のポップアップを表示するかの判定に使う
    
    @State private var nowSelectedAssighment: Assignment = Assignment(assigmentName: "placeholder", detail: "placeholder", limitDate: Date(), duration: 0, className: "placeholder") //タップされた課題を入れる（課題の削除や、編集で使う）初期値はとりあえずで入れたもの意味はない。
    
    
    var body: some View {
        
        let bounds = UIScreen.main.bounds
        let screenWidth = Int(bounds.width)
        let screenHeight = Int(bounds.height)
        
        ZStack{
            
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
                                        HStack{
                                            TaskRow(oneAssignment: oneAssignment, isSelected: $isSelected,isShowFinishPopUP: $isShowFinishPopUP)
                                            
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
                                                Image(systemName: "trash.fill")
                                                    .onTapGesture(count: 1) {
                                                        isShowDeletePopUP = true
                                                        nowSelectedAssighment = oneAssignment
                                                        
                                                    }
                                            }
                                        }
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
            
            if isShowFinishPopUP || isShowDeletePopUP{
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
            
            if isShowDeletePopUP{
                deletePopUpView(isShowDeletePopUP: $isShowDeletePopUP, nowSelectedAssignment: nowSelectedAssighment)
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
    @Binding var isShowFinishPopUP: Bool //ポップアップを表示するかの判定用
    
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
        .background(Color.white)
        
        
        
    }
}

struct deletePopUpView: View{
    @Binding var isShowDeletePopUP: Bool //ポップアップを表示するかの判定用
    var nowSelectedAssignment: Assignment //現在選択されている課題
    
    var body: some View{
        VStack{
            Text("この課題を削除しますか?")
            
            HStack{
                //キャンセルボタン
                Button(action: {
                    isShowDeletePopUP.toggle()
                }){
                    Text("キャンセル")
                }
                
                //決定ボタン。選択した要素を削除する
                Button(action: {
                    let realm = try! Realm()
                    let deletedAssignment = nowSelectedAssignment.thaw()!
                    try! realm.write {
                        realm.delete(deletedAssignment)
                    }
                    
                    isShowDeletePopUP.toggle()
                }){
                    Text("OK")
                }
            }
        }.background(Color.white)
        
    }
    
    
}
