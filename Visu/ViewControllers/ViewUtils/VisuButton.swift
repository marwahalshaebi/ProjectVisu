//
//  VisuButton.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-04.
//

import SwiftUI

struct VisuButton: View{
    // MARK: variables and state objects
    var title: String
    var foregroundColor: Color = Color.white
    var fontWeight: Font.Weight = .semibold
    var font: Font = .subheadline
    var backgroundColor: Color = Color("greenButton")
    var action: (() -> ())? =  nil
    
    //MARK: VIEW
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
