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
    }

    // MARK: - 액션 연결

    private func setupAction() {
        // 책 검색 서치바 delegate 설정
        searchView.bookSearchBar.delegate = self

        // 책 검색 결과 컬렉션뷰 dataSource 설정
        searchView.SearchResultCollectionView.dataSource = self
    }
}

// MARK: - 액션 설정

extension SearchViewController {
}

// MARK: - bookSearchBar Delegate 설정

extension SearchViewController: UISearchBarDelegate {
    // 텍스트 검색시 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색")
    }

}

// MARK: - searchResultCollectionView DataSource 설정

extension SearchViewController: UICollectionViewDataSource {
    // 섹셕별 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCollectionViewCell.id,
            for: indexPath
        ) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }

    // 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchResultCollectionViewHeader.id,
            for: indexPath
        ) as? SearchResultCollectionViewHeader else { return UICollectionReusableView() }
        return header
    }
}