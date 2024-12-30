//
//  ViewController.swift
//  BookApp
//
//  Created by mun on 12/27/24.
//

import UIKit

import SnapKit

class SearchViewController: UIViewController {

    // MARK: - UI 컴포넌트

    // 모달 연결 확인용 테스트 버튼
    private let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    // MARK: - 생명주기 메서드

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(testButton)

        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(100)
        }
    }

    // MARK: - 액션 연결

    private func setupAction() {
        // 테스트 버튼 액션 연결
        testButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.testButtonTapped()
        }, for: .touchUpInside)
    }
}

// MARK: - 액션 설정

extension SearchViewController {
    // 테스트 버튼 선택시 모달 실행
    private func testButtonTapped() {
        let bookInfoVC = BookInfoViewController()

        self.navigationController?.modalPresentationStyle = .fullScreen
        present(bookInfoVC, animated: true)
    }
}
