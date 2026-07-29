//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 29/07/2026.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {

        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
