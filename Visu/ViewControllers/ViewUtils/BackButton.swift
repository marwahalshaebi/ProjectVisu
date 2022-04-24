//
//  BackButton.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-04-22.
//

import SwiftUI

// MARK: Custom back button
struct BackButton: View {
    var action: (() -> ())? =  nil
    var body: some View {
        Button(action: {
            action?()
            
        } , label: {
            
            Image(systemName: "arrow.left")
                .resizable()
                .foregroundColor(Color.black)
        })
        .frame(width: 23, height: 20)
        .position(x: 40, y: 60)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
