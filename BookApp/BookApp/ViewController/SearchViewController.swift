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

    private let searchView = SearchView()

    // 모달 연결 확인용 테스트 버튼
    private let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    // MARK: - 생명주기 메서드

    override func loadView() {
        super.loadView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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

        // 책 검색 서치바 delegate 설정
        searchView.bookSearchBar.delegate = self
    }
}

// MARK: - 액션 설정

extension SearchViewController {
    // 테스트 버튼 선택 시 모달 실행
    private func testButtonTapped() {
        let bookInfoVC = BookInfoViewController()

        self.navigationController?.modalPresentationStyle = .fullScreen
        present(bookInfoVC, animated: true)
    }
}

// MARK: - bookSearchBar Delegate 설정

extension SearchViewController: UISearchBarDelegate {
    // 텍스트 검색시 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색")
    }

}
