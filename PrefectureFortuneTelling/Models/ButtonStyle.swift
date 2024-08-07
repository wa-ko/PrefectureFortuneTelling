//
//  ButtonStyle.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/08.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 25, weight: .semibold, design: .rounded))
            .foregroundColor(.gray)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(Color("buttonColor"))
                    .shadow(color: .white, radius: 10, x: -7, y: -7)
                    .shadow(color: Color(white: 0.8, opacity: 1), radius: 5, x: 3, y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.gray, lineWidth: 0)
            )
    }
}
