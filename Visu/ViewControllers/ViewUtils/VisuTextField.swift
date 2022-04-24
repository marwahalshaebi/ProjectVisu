//
//  VisuTextField.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-04.
//

import SwiftUI

struct VisuTextField: View {

    var title: String
    @Binding var text: String

    var securefeild: Bool = false
    
    // MARK: VIEW
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(title)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.black)
                    .frame(height: 50)

                if securefeild {
                    SecureField("", text: $text)
                        .padding()
                } else {
                    TextField("", text: $text)
                        .padding()
                }
            }
        }
    }
}

struct VisuTextFeild_Previews: PreviewProvider {
    static var previews: some View {
        VisuTextField(title: "name", text: .constant(""))
    }
}
