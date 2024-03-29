//
//  ClassDescription.swift
//  kadai_kanri
//
//  Created by K.U on 2022/07/02.
//

import SwiftUI
import RealmSwift

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct ClassDescription: View {
    
    @ObservedResults(Assignment.self) var assignments //課題のリスト
    @ObservedResults(TimeTableElement.self)  var timeTableElements //時間割モデル
    
    @Binding var day: String //受け取った曜日
    @Binding var period: Int //受け取った時間
    @Binding var state: Bool //遷移状態
    let userid:String
    
    @State private var isSelected: Bool = false
    @State private var isAddTask: Bool = false
    
    @State private var isShowFinishPopUP = false //課題を終了したときのポップアップを表示するかの判定に使う
    
    @State private var isShowDeletePopUP = false //課題を削除する時のポップアップを表示するかの判定に使う
    
    @State private var nowSelectedAssighment: Assignment = Assignment(assigmentName: "placeholder", detail: "placeholder", limitDate: Date(), duration: 0, className: "placeholder") //タップされた課題を入れる（課題の削除や、編集で使う）初期値はとりあえずで入れたもの意味はない。
    
    var body: some View {
        //受け取った曜日、時間からフィルターを作成し、科目データを取得
        let classFilter = NSPredicate(format: "dayOfWeek = %@ AND period = %@", argumentArray: ["\(day)",period]) //フィルタリングの条件を作成（曜日と何限目か指定）
        let selectedClass: Results<TimeTableElement> = timeTableElements.filter(classFilter)
        
        //受け取ったフィルターから科目を取得
        let ClassName: String = selectedClass.count != 0 ? selectedClass[0].className : ""
        
        //科目名からフィルターを作成し、科目に対する課題一覧を取得
        let assignmentFilter = NSPredicate(format: "className == %@ AND userName = %@", argumentArray: ["\(ClassName)","\(userid)"])
        let user = realmApp.currentUser!
        let filtedAssignmentsList = try! Realm(configuration: user.configuration(partitionValue: "allAssignment")).objects(Assignment.self).filter(assignmentFilter)
        
        let phone_width = UIScreen.main.bounds.size.width
        let phone_height = UIScreen.main.bounds.size.height
        let rate_width = phone_width/390
        let rate_height = phone_height/844
        
        //let filtedAssignmentsList: Results<Assignment> = assignments.filter(assignmentFilter)
        ZStack {
            Color.light_beige.ignoresSafeArea()
            VStack {
                ZStack {
                    Color.beige
                        .frame(width: screenWidth-(60*rate_height), height: 80*rate_height)
                        .border(.gray, width: 3)
                     
                    Text(ClassName)
                        .padding()
                        .font(.title)
                }
                .frame(width: screenWidth-(60*rate_height), height: 80*rate_height)
                .border(.gray, width: 3)
                .offset(x:0,y:-60*rate_height)

                ScrollView{
                    VStack {
                        Text("講義の詳細")
                            .padding(.top, 10)
                        VStack {
                            HStack {
                                VStack {
                                    Image(systemName: "person.fill")
                                    Text("担当教員")
                                }
                                Text(selectedClass[0].teacher)
                            }
                            Divider()
                            HStack {
                                VStack {
                                    Image(systemName: "clock.fill")
                                    Text("時間")
                                }
                                Text(selectedClass[0].dayOfWeek)
                                Text("\(selectedClass[0].period)")
                            }
                            Divider()
                            HStack {
                                VStack {
                                    Image(systemName: "paperplane.fill")
                                    Text("場所")
                                }
                                Text(selectedClass[0].place)
                            }
                        }
                        .padding()
                        .background(Color.light_green)
                    }
                    .frame(width: screenWidth-(60*rate_width))
                    .background(Color.beige)
                    
                    VStack {
                        Text("課題一覧")
                            .padding(.top, 10)
                        ScrollView {
                            ForEach(filtedAssignmentsList) { oneAssignment in
                                //タスク詳細画面を呼び出す
                                HStack{
                                    let realmUser = realmApp.currentUser!
                                    NavigationLink(destination: TaskDescriptionView(selectedAssignment: oneAssignment, state: $isSelected)
                                        .environment(\.realmConfiguration, realmUser.configuration(partitionValue: "allAssignment"))) {
                                        let timeDay = (oneAssignment.duration/1440)
                                        let timeHour = (oneAssignment.duration%1440)/60
                                        let timeMinute = oneAssignment.duration%60
                                        Text("""
                                            課題名:\(oneAssignment.assignmentName)
                                            所要時間:\(timeDay)日\(timeHour)時間\(timeMinute)分
                                            """)
                                            .foregroundColor(Color.black)
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
                                                    let user = realmApp.currentUser!
                                                    let realm = try! Realm(configuration: user.configuration(partitionValue: "allAssignment"))
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
                                                let user = realmApp.currentUser!
                                                let realm = try! Realm(configuration: user.configuration(partitionValue: "allAssignment"))
                                                let deletedAssignment = oneAssignment.thaw()!
                                                try! realm.write {
                                                    realm.delete(deletedAssignment)
                                                }
                                            }))
                                        }
                                    }
                                }
                                .padding()
                                .frame(width: screenWidth - (80*rate_width))
                                .background(Color.light_beige)
                            }
                        }
                        .frame(width: screenWidth-(80*rate_width))
                        .padding(10)
                        .background(Color.light_green)
                    }
                    .frame(width: screenWidth-(60*rate_width), height: 260*rate_width)
                    .background(Color.beige)
                }
                .offset(x:0,y:-40*rate_height)
                
                Button(action: {
                    state = false
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
        
            if isShowFinishPopUP{
                //色を重ねることによって画面を暗くする
                Rectangle()
                    .fill(Color.black)
                    .frame(width:CGFloat(screenWidth), height: CGFloat(screenHeight) + (50*rate_height))
                    .opacity(0.3)
            }
            
            //終了タスクポップアップ表示用
            if isShowFinishPopUP{
                finishPopUpView(isShowFinishPopUP: $isShowFinishPopUP,nowSelectedAssignment: nowSelectedAssighment)
            }
            
        }
        .navigationBarBackButtonHidden(true)

        
        /*
        if isShowDeletePopUP{
            deletePopUpView(isShowDeletePopUP: $isShowDeletePopUP, nowSelectedAssignment: nowSelectedAssighment)
        }*/
    }
}

struct ClassDescription_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


