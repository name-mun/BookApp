//
//  Book.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

struct BookResponse: Decodable {
    let documents: [Book]
}

struct Book: Decodable {
    let title: String?
    let authors: [String]?
    let price: Int?
    let contents: String?
    let thumbnail: String?
}
