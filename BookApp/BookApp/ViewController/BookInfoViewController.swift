//
//  DetailedBookViewController.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

import SnapKit

protocol BookInfoViewControllerDelegate: AnyObject {
    func updateData(_ viewController: UIViewController, index: Int?)
}


class BookInfoViewController: UIViewController {

    // MARK: - UI 컴포넌트

    private var book: Book?
    private var index: Int?
    private var isSavedView: Bool?
    weak var delegate: BookInfoViewControllerDelegate?

    private let bookInfoView = BookInfoView()

    // MARK: - 생명주기 메서드

    override func loadView() {
        super.loadView()
        view = bookInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }

    // MARK: - 레이아웃 설정
    
    private func setupUI() {
        view.backgroundColor = .white
    }

    // MARK: - 액션 연결

    private func setupAction() {
        // 닫기 버튼 액션 연결
        bookInfoView.closeButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.closeButtonTapped()
        }, for: .touchUpInside)

        // 담기 버튼 액션 연결
        bookInfoView.saveButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.saveButtonTapped()
        }, for: .touchUpInside)
    }

    // MARK: - 데이터 설정

    func configure(_ book: Book, _ isSavedView: Bool, _ index: Int?) {
        self.book = book
        self.isSavedView = isSavedView
        self.index = index

        if let thumbnail = book.thumbnail {
            NetworkManager.shared.downloadImage(thumbnail) { [weak self] image in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if let image = image {
                        self.bookInfoView.configureImage(image)
                    }
                }
            }
        }

        bookInfoView.configureData(book, isSavedView)
    }
}

// MARK: - 액션 설정

extension BookInfoViewController {
    // 닫기 버튼 설정
    private func closeButtonTapped() {
        self.delegate?.updateData(self, index: nil)
        dismiss(animated: true)
    }

    // 담기 버튼 설정
    private func saveButtonTapped() {
        guard let book = self.book else { return }

        guard let isSavedView = isSavedView else { return }

        if isSavedView {
            guard let index = index else { return }
            self.delegate?.updateData(self, index: index)

        } else {
            UserDataManager.shared.createData(book)

        }
        self.delegate?.updateData(self, index: nil)
        dismiss(animated: true)
    }
}
