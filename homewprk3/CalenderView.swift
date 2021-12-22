//
//  CalenderView.swift
//  homewprk3
//
//  Created by User12 on 2021/12/5.
//

import SwiftUI



struct dateData: Identifiable{

    let id = UUID()

    var date: Date

    var title: String

    var content: String

    var pictureName: String

}



struct CalenderView: View {

    @State private var selectTime = Date()

    @State private var selectEvents = [dateData]()

    @State private var settingPressed = false

    @State private var settingScale = 1.0

    @State private var settingFontSize = 1.0

    @State private var settingIsRandom = true

    @State private var settingColor = Color.black

    @State private var showForm = false

    

    var body: some View {

        VStack{

            HStack{

                Spacer()

                Button("設定"){

                    settingPressed = true

                }

                .fullScreenCover(isPresented: $settingPressed, content: {

                    SettingView(showForm: $settingPressed, scale: $settingScale, fontScale: $settingFontSize, isRandom: $settingIsRandom, themeColor: $settingColor)

                })

                    .padding()

            }

            HStack{

                Image("裝飾圖片")

                    .resizable()

                    .scaledToFit()

                    .frame(height: 80)

                Text("我的行事曆")

                    .font(.title)

                    .bold()

                    .padding()

            }

            

            DatePicker("我的行事曆", selection: $selectTime, displayedComponents: .date)

                .datePickerStyle(GraphicalDatePickerStyle())

                .accentColor(settingColor)

                .contextMenu{

                    Button("設定"){

                        settingPressed = true

                    }

                    .fullScreenCover(isPresented: $settingPressed, content: {

                        SettingView(showForm: $settingPressed, scale: $settingScale, fontScale: $settingFontSize, isRandom: $settingIsRandom, themeColor: $settingColor)

                    })

                    

                    Button("新增行程"){

                        showForm = true

                    }

                    .padding()

                    .foregroundColor(settingColor)

                    .sheet(isPresented: $showForm, content: {

                        AddEventView(showForm: $showForm, date: $selectTime, events: $selectEvents, themeColor: $settingColor)

                    })

                }

            EventView(selectDate: $selectTime, selectEvents: $selectEvents, scale: $settingScale, fontScale: $settingFontSize, fontColor: $settingColor, showForm: $showForm)

        }

        .foregroundColor(settingColor)

        

    }

}



func getDay(selectDate: Date) -> String {

    let calendar = Calendar.current

    let day = calendar.component(.day, from: selectDate)

    return String(day)

}



struct EventRow: View {

    let event: dateData

    @Binding var scale: Double

    @Binding var fontSize: Double

    

    var body: some View {

        HStack{

            Image(event.pictureName)

                .resizable()

                .scaledToFit()

                .frame(width: 80, height: 80, alignment: .center)

                .clipped()

                .scaleEffect(scale)

            Spacer(minLength: 30)

            VStack(alignment: .leading){

                Text(event.title)

                Text(event.content)

            }

            .padding()

            .scaleEffect(fontSize)

            Spacer()

        }

    }

}



struct EventView: View {

    @Binding var selectDate: Date

    @Binding var selectEvents: [dateData]

    @Binding var scale: Double

    @Binding var fontScale: Double

    @Binding var fontColor: Color

    @Binding var showForm: Bool

    

    var body: some View{

        

        List{

            HStack{

                Text(getDay(selectDate: selectDate))

                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                    .foregroundColor(fontColor)

                    .padding()

                Spacer()

                Button("新增行程"){

                    showForm = true

                }

                .padding()

                .foregroundColor(fontColor)

                .sheet(isPresented: $showForm, content: {

                    AddEventView(showForm: $showForm, date: $selectDate, events: $selectEvents, themeColor: $fontColor)

                })

            }

            ForEach(selectEvents){ event in

                if event.date == selectDate{

                    EventRow(event: event, scale: $scale, fontSize: $fontScale)

                }

            }

        }

    }

}



struct CalenderView_Previews: PreviewProvider {

    static var previews: some View {

        CalenderView()

    }

}

