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
    @Persisted var dayOfWeek: String //曜日
    @Persisted var period: Int //時間
    @Persisted var className: String //科目名
    @Persisted var Assignments: List<Assignment>//課題のリスト
    
    
    convenience init(dayOfWeek: String, period: Int,className: String ){
        self.init()
        self.dayOfWeek = dayOfWeek
        self.period = period
        self.className = className
    } 
}
