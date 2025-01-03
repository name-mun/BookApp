//
//  SaveBook+CoreDataClass.swift
//  BookApp
//
//  Created by mun on 1/2/25.
//
//

import Foundation
import CoreData

@objc(SaveBook)
public class SaveBook: NSManagedObject {
    public static let className = "SaveBook"
    public enum Key {
        static let title = "title"
        static let author = "author"
        static let price = "price"
        static let contents = "contents"
        static let thumbnail = "thumbnail"
    }
}
