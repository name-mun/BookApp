//
//  UserDataManager.swift
//  BookApp
//
//  Created by mun on 1/2/25.
//

import CoreData
import UIKit

class UserDataManager {

    static let shared = UserDataManager() // 싱글톤으로 생성

    lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var entity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: SaveBook.className, in: context)
    }

    private init() {}

    // 데이터 저장
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    // 데이터 생성
    func createData(_ book: Book) {
        if let entity = entity {
            let newSaveBook = NSManagedObject(entity: entity, insertInto: context)
            newSaveBook.setValue(book.title, forKey: SaveBook.Key.title)
            newSaveBook.setValue(book.authors?.first, forKey: SaveBook.Key.author)
            newSaveBook.setValue(book.price, forKey: SaveBook.Key.price)
            newSaveBook.setValue(book.contents, forKey: SaveBook.Key.contents)
            newSaveBook.setValue(book.thumbnail, forKey: SaveBook.Key.thumbnail)

            saveToContext()
        }
    }

    // 데이터 읽기
    func readData() -> [SaveBook] {
        do {
            let request = SaveBook.fetchRequest()
            let results = try context.fetch(request)
            return results
        }
        catch {
            print(error.localizedDescription)
        }
        return []
    }

    // 데이터 삭제
    func deleteData(_ book: SaveBook) {
        context.delete(book)
        saveToContext()
    }

    // 데이터 전체 삭제
    func deleteAllData() {
        let fetchResults = readData()
        for result in fetchResults {
            context.delete(result)
        }

        saveToContext()
    }
}
