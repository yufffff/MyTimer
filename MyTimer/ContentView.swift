//
//  ContentView.swift
//  MyTimer
//
//  Created by 深井裕貴 on 2021/08/14.
//

import SwiftUI

struct ContentView: View {
    // タイマーの変数を作成
    @State var timerHandler : Timer?
    // カウントの変数を作成
    @State var count = 0
    //　永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    //  アラート表示有無
    @State var showAlert = false
    var body: some View {
        NavigationView {
            // 奥から手前方向にレイアウト
            ZStack {
                Image("backgroundTimer")
                    // リサイズする
                    .resizable()
                    // セーフエリアを超えて画面全体に配置します
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    // アスペクト比を維持して短辺基準に収まるようにする
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                // 垂直にレイアウト
                // View間の間隔を30にする
                VStack(spacing: 30.0) {
                    // テキストを表示する
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    // 水平にレイアウト
                    HStack {
                        // スタートボタン
                        Button(action: {
                            // ボタンをタップしたときのアクション
                            // タイマーをカウントダウン開始する関数を呼び出す
                            startTimer()
                        }) {
                        // テキストを表示する
                        Text("スタート")
                            // 文字サイズを設定
                            .font(.title)
                            // 文字色を白に設定
                            .foregroundColor(.white)
                            // 幅高さを140に指定
                            .frame(width: 140, height: 140)
                            // 背景を設定
                            .background(Color("startColor"))
                            // 円形に切り抜く
                            .clipShape(Circle())
                        }
                        // ストップボタン
                        Button(action: {
                            // ボタンをタップしたときのアクション
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // もしタイマーが、実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        }) {
                            // テキストを表示する
                            Text("ストップ")
                                // 文字サイズを指定
                                .font(.title)
                                // 文字色を白に指定
                                .foregroundColor(.white)
                                // 幅高さを140に指定
                                .frame(width:140, height:140)
                                // 背景を設定
                                .background(Color("stopColor"))
                                // 円形に切り抜く
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }}
                }
            }
            //　画面が表示されるときに実行される
            .onAppear {
                // カウントの変数を初期化
                count = 0
            }
            .navigationBarItems(trailing:
                NavigationLink(destination: SettingView()) {
                    // テキスト表示
                    Text("秒数表示")
                }
            )
            .alert(isPresented: $showAlert) {
                // アラートを表示するためのレイアウトを記述する
                // アラートを表示する
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // 1秒毎に実行されてカウントダウンする
    func countDownTimer() {
        // countに+1していく
        count += 1
        
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()
            // アラートを表示する
            showAlert = true
        }
    }
    
    // タイマーをカウントダウン開始する関数
    func startTimer() {
        // timerHandlerを庵ラップしてunwrapedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // もしタイマーが、実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                // 何もしない
                return
            }
        }
        
        // 残り時間が0以下のとき、countを0に初期化する
        if timerValue - count <= 0 {
            // countを0に初期化する
            count = 0
        }
        
        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // タイマー実行時に呼び出される
            // 1秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
