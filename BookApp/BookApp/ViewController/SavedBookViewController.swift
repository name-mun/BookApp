//
//  StoredBookViewController.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

import SnapKit

class SavedBookViewController: UIViewController {

    // MARK: - UI 컴포넌트

    private var books: [SaveBook]?

    private let savedBookView = SavedBookView()

    // MARK: - 생명주기 메서드

    override func loadView() {
        view = savedBookView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        books = UserDataManager.shared.readData()
        savedBookView.savedBookCollectionView.reloadData()
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        savedBookView.savedBookCollectionView.dataSource = self
    }

    // MARK: - 액션 연결

    private func setupAction() {
        // 전체삭제 버튼 액션 연결
        savedBookView.allDeleteButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            self.allDeleteButtonTapped()
        }, for: .touchUpInside)

        // 추가 버튼 액션 연결
        savedBookView.addButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            self.addButtonTapped()
        }, for: .touchUpInside)
    }
}

// MARK: - 액션 설정

extension SavedBookViewController {
    // 전체삭제 버튼 선택 시 실행
    private func allDeleteButtonTapped() {
        UserDataManager.shared.deleteAllData()
        books = []
        savedBookView.savedBookCollectionView.reloadData()
    }

    // 추가 버튼 선택 시 실행
    private func addButtonTapped() {
        self.tabBarController?.selectedIndex = 0
    }
}

// MARK: - 컬렉션뷰 Delegate 설정

extension SavedBookViewController: UICollectionViewDelegate {
}

// MARK: - 컬렉션뷰 DataSource 설정

extension SavedBookViewController: UICollectionViewDataSource {
    // 섹셕별 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let books = books else { return 0 }
        return books.count
    }

    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookListCollectionViewCell.id,
            for: indexPath
        ) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        if let books = books {
            let book = books[indexPath.item]
            cell.configure(title: book.title, author: book.author, price: Int(book.price))
        }

        return cell
    }
}
