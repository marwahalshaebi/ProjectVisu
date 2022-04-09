//
//  VisuButton.swift
//  Visu
//
//  Created by iMac on 04/03/22.
//

import SwiftUI

struct VisuButton: View{
    var title: String
    var foregroundColor: Color = Color.white
    var fontWeight: Font.Weight = .semibold
    var font: Font = .subheadline
    var backgroundColor: Color = Color("greenButton")
    var action: (() -> ())? =  nil

    var body: some View{
        Button {
            action?()
        } label: {
            Text(title)
                .foregroundColor(foregroundColor)
                .fontWeight(fontWeight)
                .font(font)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(backgroundColor)
                .clipShape(SqureCornerRadius())
        }

    }

}
