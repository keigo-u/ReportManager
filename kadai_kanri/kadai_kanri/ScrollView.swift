//
//  ScrollView.swift
//  kadai_kanri
//
//  Created by kuniyoshi on 2022/07/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //UIScrollViewのインスタンス作成
        let scrollView = UIScrollView()

        //scrollViewの大きさを設定。
        scrollView.frame = self.view.frame

        //スクロール領域の設定
        scrollView.contentSize = CGSize(width:self.view.frame.width, height:1000)

        //scrollViewをviewのSubViewとして追加
        self.view.addSubview(scrollView)
    }
}
