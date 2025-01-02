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

    func configure(_ book: Book) {
        if let thumbnail = book.thumbnail {
            downloadImage(thumbnail)
        }

        bookInfoView.configureData(book)
    }
}

// MARK: - 액션 설정

extension BookInfoViewController {
    // 닫기 버튼 설정
    private func closeButtonTapped() {
        dismiss(animated: true)
    }

    // 담기 버튼 설정
    private func saveButtonTapped() {
        print("저장")
    }
}

// MARK: - 이미지 다운로드

extension BookInfoViewController {
    // 이미지 다운로드
    func downloadImage(_ thumbnail: String) {
        guard let url = URL(string: thumbnail) else { return }

        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.bookInfoView.configureImage(image)
                }
            }
        }
    }
}
