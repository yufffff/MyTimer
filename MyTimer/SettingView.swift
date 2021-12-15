//
//  SettingView.swift
//  MyTimer
//
//  Created by 深井裕貴 on 2021/08/14.
//

import SwiftUI

struct SettingView: View {
    @AppStorage ("timer_value") var timerValue = 10
    // 奥から手前にレイアウト
    var body: some View {
        ZStack {
            // 背景色表示
            Color("backgroundSetting")
                // セーフエリアを超えて画面全体に配置します
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            // 垂直にレイアウト
            VStack {
                // スペースを空ける
                Spacer()
                
                // テキストを表示する
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                
                // スペースを空ける
                Spacer()
                
                // Pickerを表示
                Picker(selection: $timerValue, label: Text("選択")) {
                    Text("10").tag(10)
                    Text("20").tag(20)
                    Text("30").tag(30)
                    Text("40").tag(40)
                    Text("50").tag(50)
                    Text("60").tag(60)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
