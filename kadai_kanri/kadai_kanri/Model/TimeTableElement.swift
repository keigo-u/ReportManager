//
//  TimeTableElement.swift
//  kadai_kanri
//
//  Created by 當山寛人 on 2022/06/02.
//

import Foundation
import RealmSwift

class TimeTableElement: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id: ObjectId //ID
    @Persisted var dayOfWeek: String //曜日 月、火、水、・・・
    @Persisted var period: Int //時間
    @Persisted var className: String //科目名
    @Persisted var Assignments: List<Assignment>//課題のリスト
    @Persisted var teacher: String //担当教員
    @Persisted var place: String //場所
    
    
    convenience init(dayOfWeek: String, period: Int,className: String, teacher: String, place: String){
        self.init()
        self.dayOfWeek = dayOfWeek
        self.period = period
        self.className = className
        self.teacher = teacher
        self.place = place
    } 
}
