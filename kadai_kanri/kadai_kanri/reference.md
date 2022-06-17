#  参考にしたものをここに置いておこうと思う


[時間・分・秒への変換](https://proglight.jimdofree.com/learning/timeconvert/)

意外とわかんなくなる


[【Xcode/Swift】RealmSwiftでエラー：Thread 1: Fatal error: ‘try!’ expression unexpectedly raised an error: Error Domain=io.realm Code=10 “Migration is required due to the following errors:](https://ios-docs.dev/realm-migration/)

今後引っかかりそう。Realmで扱うオブジェクトのプロパティを変更したりすると発生するみたい

[【Xcode】初学者が出会ったエラー 虎の巻 "Cannot use instance member 'hoge' ~~"](https://qiita.com/kudpig/items/02dff090d763abf5918d)

[ObservedResults](https://www.mongodb.com/docs/realm-sdks/swift/latest/Structs/ObservedResults.html#/s:10RealmSwift15ObservedResultsV5whereAA5QueryVySbGAFyxGcSgvp)

filteringはNSなんたらオブジェクトを作って渡してあげてばいけるみたい。

[【SwiftUI】画面を閉じるdismissとisPresentedについて](https://capibara1969.com/3700/)

戻る画面を作るのに使ったかも？


[Xcode Preview crashes because of RealmSwift model changes](https://stackoverflow.com/questions/66735100/xcode-preview-crashes-because-of-realmswift-model-changes)

後でためす。うまくいくといいね。

[【SwiftUI】TextField付きAlertを表示する](https://www.yururiwork.net/archives/1315)

よくわからない文法がたくさん有る方法・・・コードを読みやすくするためには上のような方法がいいんだろうけど、正直書ける気がしないので、ZStackで上に表示する
ストロングスタイルでいかせてもらいます。

# 困っていること

- タスク管理画面からタスク詳細画面へ移行する際に、クリックされた箇所に対応するselectedassignmentを渡すのだけれども、どうもうまくいってない

##解決かも
```

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
        //.onTapGesture{
            //isSelected = true
        //}
        //.navigationBarHidden(true)
```

NavigationLink(destination: TaskDescriptionView(selectedAssignment: oneAssignment, state: $isSelected),isActive: $isSelected)
としていたのが原因ぽかった。
多分NavigationLinkのisActiveが原因。
NavigationLinkのViewをクリックすると、画面が遷移する。遷移するとこのisActiveの値もtrueになるみたい。

これが悪さをしているんじゃないかな？

多分だけど、foreachでnavigationLinkを作りまくっていて、全部引数にisActiveを持っている。
で、一つのnavigationLinkをクリックすると、他のNavigationLinkのisActiveの値も、trueに変わる。
そうすると、isActiveがtrueなので、他のNavigationLinkもdestivationの箇所を表示しようと頑張って、
意図していない（タップしていない）箇所のNavigationLinkが呼び出されると思う。
多分ね。

isActiveを使うときはそれに注意しないといけないのかも・・・


### realmのオブジェクトをbindingで渡さない方がいいのかも！
bindingで渡さないようにするとフリーズしないようになった！

