//
//  DetailedBookViewController.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

import SnapKit

class BookInfoViewController: UIViewController {

    // MARK: - UI 컴포넌트

    private let bookInfoView = BookInfoView()

    // MARK: - 생명주기 메서드

    override func loadView() {
        super.loadView()
        view = bookInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - 레이아웃 설정
    
    private func setupUI() {
        view.backgroundColor = .white
    }

    // MARK: - 데이터 설정

    func configure(_ book: Book) {
        print(book)
    }
}
