//
//  Assignment.swift
//  kadai_kanri
//
//  Created by 當山寛人 on 2022/06/02.
//

import Foundation
import RealmSwift

class Assignment: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id: ObjectId //ID
    @Persisted var assignmentName: String //課題名
    @Persisted var detail: String //課題詳細
    @Persisted var limitDate: Date //期限
    @Persisted var duration: Int //所要時間
    @Persisted var className: String //科目名
    @Persisted var userName: String  = "anonymous"//ユーザー名（とりあえず今はデフォルトで入っていることにする）
    
    
    convenience init(assigmentName: String, detail: String,limitDate: Date ,duration: Int,className: String){
        self.init()
        self.assignmentName = assigmentName
        self.detail = detail
        self.limitDate = limitDate
        self.duration = duration
        self.className = className
    }
}
