//
//  NumberFormatter.swift
//  BookApp
//
//  Created by mun on 12/31/24.
//

import Foundation

struct PriceFormatterModel {

    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    // 원화로 바꿔주는 메서드
    static func wonFormatter(_ price: Int) -> String {
        guard let result = numberFormatter.string(for: price) else { return "" }

        return "\(result)원"
    }
}

