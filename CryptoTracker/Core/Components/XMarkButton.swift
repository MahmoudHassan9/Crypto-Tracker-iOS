//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 01/08/2026.
//

import SwiftUI

struct XMarkButton: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(
            action: {
                presentationMode.wrappedValue.dismiss()
            },
            label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
        )
    }
}
#Preview {
    XMarkButton()
}
