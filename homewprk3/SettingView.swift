//
//  SettingView.swift
//  homewprk3
//
//  Created by User12 on 2021/12/22.
//

import SwiftUI



let color = [Color.black, Color.blue, Color.brown, Color.cyan, Color.gray, Color.green, Color.indigo]



struct SettingView: View {

    @Binding var showForm: Bool

    @Binding var scale: Double

    @Binding var fontScale: Double

    @Binding var isRandom: Bool

    @Binding var themeColor: Color

    

    var body: some View {

        VStack{

        Form{

            VStack

            {

                EventRow(event: dateData(date: Date(), title: "測試標題", content: "測試內容", pictureName: "休息"), scale: $scale, fontSize: $fontScale)

                HStack{

                    Text("設定圖片大小")

                    Slider(value: $scale, in: 0.5...1)

                        .accentColor(themeColor)

                }

                HStack{

                    Text("設定字體大小")

                    Stepper("\(fontScale.formatted())", value: $fontScale, in: 1...3, step: 0.25)

                }

                DisclosureGroup("顏色設定"){

                    Toggle("隨機顏色", isOn: $isRandom)

                        .onChange(of: isRandom) { value in

                            if value{

                                themeColor = color.randomElement()!

                            }

                        }

                    if isRandom == false{

                        ColorPicker("選擇顏色", selection: $themeColor)

                    }

                }

            }

        }

        .foregroundColor(themeColor)

            

            Button{

                showForm = false

                

            } label: {

                Text("返回")

            }

            .padding()

        }

    }

}

