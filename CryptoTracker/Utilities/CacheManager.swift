//
//  CasheManager.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 29/07/2026.
//

import Foundation
import SwiftUI

protocol CacheProtocol {
    func data(for key: String) -> Data?
    func insertData(_ data: Data, for key: String)
}

final class ImageCache: CacheProtocol {
    private let cache = NSCache<NSString, NSData>()

    func data(for key: String) -> Data? {
        cache.object(forKey: key as NSString) as Data?
    }

    func insertData(_ data: Data, for key: String) {
        cache.setObject(
            data as NSData,
            forKey: key as NSString,
            cost: data.count
        )
    }
}
