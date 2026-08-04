//
//  String.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 04/08/2026.
//

import Foundation

extension String {

    var removingHTMLOccurances: String {
        return self.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }

}
