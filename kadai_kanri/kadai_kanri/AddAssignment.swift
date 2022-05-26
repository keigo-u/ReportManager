//
//  ContentView.swift
//  sample
//
//  Created by kuniyoshi on 2022/05/12.
//

import SwiftUI

struct AddAssignment: View {

let hours: [Int] = Array(0..<24)
let minutes: [Int] = Array(0..<60)
    @State var SubjectName = ""
    @State var AssignmentName = ""
    @State var Time:[Int] = [0,0,0]
    @State var Remarks = ""
    @State var select = 0
    @Binding var state :Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
    let bounds =  UIScreen.main.bounds
    let width = CGFloat(bounds.width)
    let height = CGFloat(bounds.height)
   
        NavigationView{
            VStack{
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
            }.navigationTitle("課題追加画面")
            Button(action:{
                state = false
                presentationMode.wrappedValue.dismiss()
            }){
            Text("追加")
            .frame(width: width,height: (height/10))
            .border(Color.gray)
            }
        }
        }
    }
}
/*
struct AddAssignment_Previews: PreviewProvider {
    static var previews: some View {
    Group {
        if #available(iOS 15.0, *) {
            AddAssignment()
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
            
    }
}
*/
