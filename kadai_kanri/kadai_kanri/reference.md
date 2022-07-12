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

後でためす。うまくいくといいね。めちゃめちゃうまくいった！！！！ありがとう！！！！

[【SwiftUI】TextField付きAlertを表示する](https://www.yururiwork.net/archives/1315)

よくわからない文法がたくさん有る方法・・・コードを読みやすくするためには上のような方法がいいんだろうけど、正直書ける気がしないので、ZStackで上に表示する
ストロングスタイルでいかせてもらいます。

[How to fix “Cannot assign to property: 'self' is immutable”](https://www.hackingwithswift.com/quick-start/swiftui/how-to-fix-cannot-assign-to-property-self-is-immutable)

正直なんで直ったかわからんが治った。本来は変更できないものなの？！

[【Xcode 6】対応する開き括弧と閉じ括弧を調べる方法](https://egg-is-world.com/2015/01/09/xcode-brace-check/)

[FFmpegで動画をGIFに変換](https://qiita.com/wMETAw/items/fdb754022aec1da88e6e)

[【SwiftUI】@Stateの使い方](https://capibara1969.com/1608/)

かなりよく忘れる

[Swift4.2でBool値の反転をtoggleで行う](https://qiita.com/iganin/items/7cceb4c644fddfaeef62)

[\[SwiftUI\] VStackの配置、余白、背景色等の設定](https://swiftui.i-app-tec.com/ios/vstack.html#4)

背景色を変える方法を知りたくて

[【Swift入門】if文による条件分岐の書き方を徹底解説！](https://www.sejuku.net/blog/33598)

orの書き方を知りたくて

[編集ソフトを使わずにCSSで画像を暗くするテクニック](https://kouhekikyozou.com/css_image_darken)

ポップアップを出すときに使った

[【SwiftUI】TextFieldに数字のみ入力しキーボードを閉じる](https://rougo-fukugyo.com/archives/2845)

[【Realm】データの更新・削除（Update・Delete）処理の書き方](https://naoya-ono.com/swift/realm-update-delete/)

データの削除のやり方を見た

[【SwiftUI】アラートの使い方（alert）](https://capibara1969.com/3757/)

[SwiftUI「アラート(Alert)」が表示されない3つの原因](https://www.choge-blog.com/programming/swiftui%E3%80%8C%E3%82%A2%E3%83%A9%E3%83%BC%E3%83%88alert%E3%80%8D%E3%81%8C%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%81%AA%E3%81%843%E3%81%A4%E3%81%AE%E5%8E%9F%E5%9B%A0/)


## realmデータ共有のために調べたもの！

正直なんで動いているかわからない・・・何かトラブルがあったらもう何もすることはできない・・・

[Swiftで小数点の桁数表示を調整する方法](https://ymgsapo.com/2022/01/07/swift-dicimal-format/)

swiftuiでは関数が使える時と使えない時がある・・・違いは？

[SwiftのFloat系の演算で余り演算子(%)が廃止、それに変わるメソッドはだるま落としと最寄駅](https://qiita.com/samekard/items/81e095832b1cde9b71ba)

[List](https://www.mongodb.com/docs/realm-legacy/docs/swift/latest/api/Classes/List.html#/s:10RealmSwift4ListCA2A11AddableTypeRzrlE7averageqd__SgyAaDRd__lF)

list.average()の使い方を見ていた。（が、全くわかっていない。戻り値をDoubleにしたらたまたまうまく動いた）

[SwiftUI Argument passed to call that takes no arguments](https://stackoverflow.com/questions/68324357/swiftui-argument-passed-to-call-that-takes-no-arguments)

initを使っているとselfをつけないといけなくなる？そもそもswiftの構文ちんぷんかんぷんだからわけわからんね

[Sample realm sync with partition keys for different types (public, private, group)](https://www.mongodb.com/community/forums/t/sample-realm-sync-with-partition-keys-for-different-types-public-private-group/7251)

[Partitions](https://www.mongodb.com/docs/atlas/app-services/sync/data-access-patterns/partitions/#std-label-sync-partitions)

[MongoDB Realm ObservableObject, SwiftUI?](https://stackoverflow.com/questions/64509881/mongodb-realm-observableobject-swiftui)

チュートリアルでデータを共有する時は、navigationlinkに.environmentなんたら〜ってやっていたけど、それ以外の方法。
configrationを設定してあげれば、色々なpartitionを使えるようになるらしい。（がもう・・・全てのパーティションをallassighmentにしちゃっているけど・・・パーティションの意味ないよな・・・）


[【SwiftUI】Fatal error: Unexpectedly found nil while unwrapping an Optional valueの対応方法を日本語で解説](https://tomato-develop.com/swiftui-fatal-error-unexpectedly-found-nil-while-unwrapping-an-optional-value/)

[Swift Optional 型についてのまとめ Ver2](https://qiita.com/cotrpepe/items/518c4476ca957a42f5f1)

nilだいいきらい！！！！！！

[Git コンフリクト解消手順](https://qiita.com/crarrry/items/c5964512e21e383b73da)

[第4話 コンフリクトは怖くない！解決方法【連載】マンガでわかるGit ～コマンド編～](https://www.r-staffing.co.jp/engineer/entry/20190927_1)


[Gitでよくあるハプニングの対策とコマンドメモ](https://qiita.com/gilly/items/d590528c8309b8e37562)

[Realmのfilterメソッドの使い方](https://frog9.com/post/19)

[Add Results.distinct(by:) / -\[RLMResults distinctResultsUsingKeyPaths:\], which return a Results containing only objects with unique values at the given key paths.](https://github.com/realm/realm-swift/releases/tag/v3.1.0)

[distinct query in Realm database #1103](https://github.com/realm/realm-swift/issues/1103)

[Filter realm objects to only get one (distinct) object by attribute](https://stackoverflow.com/questions/48742646/filter-realm-objects-to-only-get-one-distinct-object-by-attribute)

使えそうなものたち
1
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

