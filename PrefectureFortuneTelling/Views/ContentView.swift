//
//  ContentView.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/04.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var birthday = Date()
    @State private var bloodType = ""
    @State private var fortuneResponse: FortuneResponse?
    @State private var isShowingResult = false
    @State private var isShowingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Group {
                    HStack {
                        Text("名前:")
                        TextField("名前を入力してください", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("誕生日:")
                        DatePicker("誕生日を選択してください", selection: $birthday, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                    }
                    HStack {
                        Text("血液型:")
                        Picker("血液型を選択してください", selection: $bloodType) {
                            Text("A").tag("a")
                            Text("B").tag("b")
                            Text("AB").tag("ab")
                            Text("O").tag("o")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .padding(.vertical, 5)

                Spacer()

                Button(action: {
                    if name.isEmpty && bloodType.isEmpty {
                        alertMessage = "名前と血液型を入力してください"
                        isShowingAlert = true
                    } else if name.isEmpty {
                        alertMessage = "名前を入力してください"
                        isShowingAlert = true
                    } else if bloodType.isEmpty {
                        alertMessage = "血液型を選択してください"
                        isShowingAlert = true
                    } else {

                        let request = setComponents(birthday: birthday, bloodType: bloodType)

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
                    }
                }) {
                    Text("占う")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.vertical)
                .alert(
                    Text("入力エラー"),
                    isPresented: $isShowingAlert
                ) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }

                Spacer()

            }
            .padding()
            .navigationTitle("相性の良い都道府県占い")
            .navigationDestination(isPresented: $isShowingResult) {
                ResultView(name: $name, fortuneResponse: $fortuneResponse)
            }
        }
    }

    private func setComponents(birthday: Date, bloodType: String) -> FortuneRequest {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: birthday)
        let birthday = YearMonthDay(year: components.year ?? 2_000, month: components.month ?? 1, day: components.day ?? 1)
        let today = YearMonthDay(year: Calendar.current.component(.year, from: Date()),
                                 month: Calendar.current.component(.month, from: Date()),
                                 day: Calendar.current.component(.day, from: Date()))
        return FortuneRequest(name: name, birthday: birthday, bloodType: bloodType, today: today)
    }
}

#Preview {
    ContentView()
}
