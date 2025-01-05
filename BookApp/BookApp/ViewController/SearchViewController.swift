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

    private var recentBook = [Book]() // 최근 본 책 저장
    private var searchResult = [Book]() // API로 부터 받은 데이터 저장

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
        searchView.searchResultCollectionView.reloadData()
        collectionViewReload()
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

            self.searchResult = result.documents // 데이터 저장

            // 컬렉션뷰 리로드
            DispatchQueue.main.async {
                self.collectionViewReload()
            }
        }
    }
}

// MARK: - searchResultCollectionView Delegate 설정

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookInfoVC = BookInfoViewController()
        bookInfoVC.delegate = self
        bookInfoVC.configure(searchResult[indexPath.row], false, nil)

        self.navigationController?.modalPresentationStyle = .fullScreen
        present(bookInfoVC, animated: true)

        if recentBook.count > 9 {
            recentBook.removeLast()
        }

        recentBook.insert(searchResult[indexPath.row], at: 0)
    }
}

// MARK: - searchResultCollectionView DataSource 설정

extension SearchViewController: UICollectionViewDataSource {
    // 컬렉션뷰 리로드
    func collectionViewReload() {
        searchView.searchResultCollectionView.reloadData()

        let recentBookIsEmpty = recentBook.count == 0 ? true : false
        let searchResultIsEmpty = searchResult.count == 0 ? true : false

        searchView.configureLayout(searchResultIsEmpty)

        let layout = searchView.searchResultCollectionView.searchViewLayout(recentBookIsEmpty: recentBookIsEmpty, searchResultIsEmpty: searchResultIsEmpty) // 빈 섹션 숨기기

        searchView.searchResultCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    // 섹션 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    // 섹셕별 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .recentBook:
            return recentBook.count
        case .searchResult:
            return searchResult.count
        default: return 0
        }
    }

    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch Section(rawValue: indexPath.section) {
        case .recentBook:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentBookCollectionViewCell.id,
                for: indexPath
            ) as? RecentBookCollectionViewCell else { return UICollectionViewCell() }
            let book = recentBook[indexPath.item]
            if let thumbnail = book.thumbnail {
                NetworkManager.shared.downloadImage(thumbnail) { image in
                    DispatchQueue.main.async {
                        cell.configure(image)
                    }
                }
            }
            return cell

        case .searchResult:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookListCollectionViewCell.id,
                for: indexPath
            ) as? BookListCollectionViewCell else { return UICollectionViewCell() }
            let book  = searchResult[indexPath.row]
            cell.configure(title: book.title, author: book.authors?.first, price: book.price)
            return cell
        default: return UICollectionViewCell()
        }
    }

    // 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchResultCollectionViewHeader.id,
            for: indexPath
        ) as? SearchResultCollectionViewHeader else { return UICollectionReusableView() }

        let sectionType = Section.allCases[indexPath.section]
        header.configure(sectionType.title)
        
        return header
    }
}

// MARK: - BookInfoViewController Delegate 설정

extension SearchViewController: BookInfoViewControllerDelegate {
    func updateData(_ viewController: UIViewController, index: Int?) {
        collectionViewReload()
    }
}
