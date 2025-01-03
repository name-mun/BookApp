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

    private var dataSouce = [Book]() // API로 부터 받은 데이터 저장

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

        // 책 검색 결과 컬렉션뷰 설정
        searchView.searchResultCollectionView.delegate = self
        searchView.searchResultCollectionView.dataSource = self
    }
}

// MARK: - 액션 설정

extension SearchViewController {
}

// MARK: - bookSearchBar Delegate 설정

extension SearchViewController: UISearchBarDelegate {
    // 텍스트 검색시 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = self.searchView.bookSearchBar.text else { return }
        NetworkManager.shared.fetchData(title: searchText) { [weak self] (result: BookResponse?) in
            guard let self, let result else { return }

            self.dataSouce = result.documents // 데이터 저장

            // 컬렉션뷰 리로드
            DispatchQueue.main.async {
                self.searchView.searchResultCollectionView.reloadData()
            }
        }
    }

}

// MARK: - searchResultCollectionView Delegate 설정

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookInfoVC = BookInfoViewController()
        bookInfoVC.configure(dataSouce[indexPath.row], false, nil)

        self.navigationController?.modalPresentationStyle = .fullScreen
        present(bookInfoVC, animated: true)

    }
}

// MARK: - searchResultCollectionView DataSource 설정

extension SearchViewController: UICollectionViewDataSource {
    // 섹셕별 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSouce.count
    }

    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookListCollectionViewCell.id,
            for: indexPath
        ) as? BookListCollectionViewCell else { return UICollectionViewCell() }
        let book  = dataSouce[indexPath.row]
        cell.configure(title: book.title, author: book.authors?.first, price: book.price)
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
