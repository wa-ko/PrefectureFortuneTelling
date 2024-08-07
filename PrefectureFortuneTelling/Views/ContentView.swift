//
//  ContentView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/04.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var year = 2_000
    @State private var month = 1
    @State private var day = 1
    @State private var bloodType = ""
    @State private var fortuneResponse: FortuneResponse?
    @State private var isShowingResult = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        Text("名前:")
                        TextField("名前を入力してください", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("誕生年:")
                        TextField("誕生年を入力してください", value: $year, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("誕生月:")
                        TextField("誕生月を入力してください", value: $month, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("誕生日:")
                        TextField("誕生日を入力してください", value: $day, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("血液型:")
                        TextField("血液型を入力してください", text: $bloodType)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.vertical, 5)

                Button(action: {
                    let birthday = YearMonthDay(year: year, month: month, day: day)
                    let today = YearMonthDay(year: Calendar.current.component(.year, from: Date()),
                                             month: Calendar.current.component(.month, from: Date()),
                                             day: Calendar.current.component(.day, from: Date()))
                    let request = FortuneRequest(name: name, birthday: birthday, bloodType: bloodType, today: today)

                    API().fetchFortune(request: request) { result in
                        switch result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                self.fortuneResponse = response
                                self.isShowingResult = true
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }) {
                    Text("占う")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.vertical)

                NavigationLink(destination: ResultView(fortuneResponse: $fortuneResponse), isActive: $isShowingResult) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("相性の良い都道府県占い")
        }
    }
}

#Preview {
    ResultView(fortuneResponse: .constant(nil))
}

#Preview {
    ContentView()
}
