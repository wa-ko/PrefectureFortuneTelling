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
                        Text("NamePrompt")
                        TextField("EnterName", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("BirthdayPrompt")
                        DatePicker("SelectBirthday", selection: $birthday, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                    }
                    HStack {
                        Text("BloodTypePrompt")
                        Picker("ChooseBloodType", selection: $bloodType) {
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
                        alertMessage = "GeneralInputError"
                        isShowingAlert = true
                    } else if name.isEmpty {
                        alertMessage = "NameInputError"
                        isShowingAlert = true
                    } else if bloodType.isEmpty {
                        alertMessage = "BloodTypeInputError"
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
                    Text("FortuneButton")
                }
                .buttonStyle(MyButtonStyle())
                .padding(.vertical)
                .alert(
                    Text("InputErrorAlert"),
                    isPresented: $isShowingAlert
                ) {
                    Button("OkButton", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }

                Spacer()

            }
            .padding()
            .navigationTitle("CompatibilityFortuneTelling")
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
