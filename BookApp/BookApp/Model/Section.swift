//
//  Section.swift
//  BookApp
//
//  Created by mun on 1/3/25.
//

enum Section: Int, CaseIterable {
    case recentBook
    case searchResult

    var title: String {
        switch self {
        case .recentBook: return "최근 본 책"
        case .searchResult: return "검색 결과"
        }
    }
}
