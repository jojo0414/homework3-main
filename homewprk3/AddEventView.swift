//
//  AddEventView.swift
//  homewprk3
//
//  Created by User12 on 2021/12/5.
//

import SwiftUI



let pictureNames = ["休息", "吃飯", "工作", "快樂", "緊急", "難過"]



struct AddEventView: View {

    @Binding var showForm: Bool

    @Binding var date: Date

    @Binding var events: [dateData]

    @Binding var themeColor: Color

    

    @State private var eventName = ""

    @State private var eventContent = ""

    @State private var pictureNo = 0

    @State private var showAlert = false

    

    var body: some View {

        VStack{

            Form{

                VStack

                {

                    TextField("行程名稱", text: $eventName)

                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        .padding()

                    

                    HStack{

                        Picker(selection: $pictureNo){

                            ForEach(pictureNames.indices){ item in

                                Text(pictureNames[item])

                            }

                        }label: {

                            Text("選擇圖片")

                        }

                        .pickerStyle(.wheel)

                        .frame(width: 100)

                        Image(pictureNames[pictureNo])

                            .resizable()

                            .scaledToFit()

                            .frame(width: 150)

                    }

                    

                    HStack{

                        Text("行程內容：")

                        Spacer()

                    }

                    TextEditor(text: $eventContent)

                        .frame(height: 150)

                        .padding()

                        .border(Color.gray, width: 1)

                }

            }

            .foregroundColor(themeColor)

            

            Button{

                showAlert = true

            } label: {

                Text("儲存行程")

            }

            .padding()

            .alert("已新增", isPresented: $showAlert, actions: {

                Button("ok"){

                    showForm = false

                    events.append(dateData(date: date, title: eventName, content: eventContent, pictureName: pictureNames[pictureNo]))

                }

            })

        }

    }

}

