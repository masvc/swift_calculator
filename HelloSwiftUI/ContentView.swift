//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by masato yoshida on 2025/02/01.
//

import SwiftUI

struct ContentView: View {
    // ディスプレイに表示するテキスト
    @State private var displayText: String = ""
    // 現在の演算子
    @State private var currentOperation: String = ""
    // 最初の数字
    @State private var firstNumber: String = ""
    // 二番目の数字
    @State private var secondNumber: String = ""
    
    var body: some View {
        VStack {
            // 上部ディスプレイ
            // 数字や計算結果を表示する部分
            Text(displayText.isEmpty ? "0" : displayText)
                .font(.largeTitle) // 大きな文字サイズ
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .trailing) // 幅と高さを設定し、右寄せ
                .padding(.trailing, 20) // 右側に余白を追加
                .background(Color.gray.opacity(0.2)) // 背景色を設定
                .padding() // 全体の余白を追加
            
            // 中部の数字ボタン
            VStack {
                // 1から9までの数字ボタンを作成
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(1..<4) { column in
                            let number = row * 3 + column
                            Button(action: {
                                numberButtonTapped("\(number)")
                            }) {
                                Text("\(number)")
                                    .font(.title) // ボタンの文字サイズ
                                    .frame(width: 60, height: 60) // ボタンのサイズ
                                    .background(Color.blue.opacity(0.2)) // ボタンの背景色
                                    .cornerRadius(10) // ボタンの角を丸くする
                            }
                        }
                    }
                }
                // 0のボタンを追加
                HStack {
                    Button(action: {
                        numberButtonTapped("0")
                    }) {
                        Text("0")
                            .font(.title) // ボタンの文字サイズ
                            .frame(width: 60, height: 60) // ボタンのサイズ
                            .background(Color.blue.opacity(0.2)) // ボタンの背景色
                            .cornerRadius(10) // ボタンの角を丸くする
                    }
                }
            }
            
            // 下部の演算子ボタン
            HStack {
                // 演算子ボタンを作成
                ForEach(["+", "-", "*", "/"], id: \.self) { operation in
                    Button(action: {
                        operationButtonTapped(operation)
                    }) {
                        Text(operation)
                            .font(.title) // ボタンの文字サイズ
                            .frame(width: 60, height: 60) // ボタンのサイズ
                            .background(Color.green.opacity(0.2)) // ボタンの背景色
                            .cornerRadius(10) // ボタンの角を丸くする
                    }
                }
                // 結果を表示するためのボタン
                Button(action: {
                    calculateResult()
                }) {
                    Text("=")
                        .font(.title) // ボタンの文字サイズ
                        .frame(width: 60, height: 60) // ボタンのサイズ
                        .background(Color.red.opacity(0.2)) // ボタンの背景色
                        .cornerRadius(10) // ボタンの角を丸くする
                }
            }
            .padding() // 余白を追加
            
            // クリアボタンを追加
            Button(action: {
                clearDisplay()
            }) {
                Text("Clear")
                    .font(.title) // ボタンの文字サイズ
                    .frame(width: 260, height: 60) // ボタンのサイズ
                    .background(Color.orange.opacity(0.2)) // ボタンの背景色
                    .cornerRadius(10) // ボタンの角を丸くする
            }
            .padding() // 余白を追加
        }
    }
    
    // 数字ボタンが押されたときの処理
    private func numberButtonTapped(_ number: String) {
        // 演算子が選択されていない場合、最初の数字を更新
        if currentOperation.isEmpty {
            firstNumber += number
            displayText = firstNumber
        } else {
            // 演算子が選択されている場合、二番目の数字を更新
            secondNumber += number
            displayText = firstNumber + currentOperation + secondNumber
        }
    }
    
    // 演算子ボタンが押されたときの処理
    private func operationButtonTapped(_ operation: String) {
        // 最初の数字が入力されていて、二番目の数字がまだ入力されていない場合
        if !firstNumber.isEmpty && secondNumber.isEmpty {
            currentOperation = operation
            displayText = firstNumber + currentOperation
        }
    }
    
    // 結果を計算する
    private func calculateResult() {
        // 入力された数字をDouble型に変換
        guard let firstValue = Double(firstNumber),
              let secondValue = Double(secondNumber) else { return }
        
        var result: Double = 0
        
        // 選択された演算子に応じて計算
        switch currentOperation {
        case "+":
            result = firstValue + secondValue
        case "-":
            result = firstValue - secondValue
        case "*":
            result = firstValue * secondValue
        case "/":
            result = firstValue / secondValue
        default:
            break
        }
        
        // 計算結果を整数として表示するか、小数として表示するかを決定
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            // 整数の場合、小数点以下を表示しない
            displayText = String(format: "%.0f", result)
        } else {
            // 小数の場合、そのまま表示
            displayText = String(result)
        }
        
        // 計算結果を次の計算のために最初の数字として設定
        firstNumber = String(result)
        secondNumber = ""
        currentOperation = ""
    }
    
    // ディスプレイをクリアする
    private func clearDisplay() {
        // すべての状態をリセット
        displayText = ""
        firstNumber = ""
        secondNumber = ""
        currentOperation = ""
    }
}

#Preview {
    ContentView()
}
