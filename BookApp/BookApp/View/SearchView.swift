//
//  SearchView.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

import SnapKit

class SearchView: UIView {

    // MARK: - UI 컴포넌트

    // 책 검색 서치바
    var bookSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsSearchResultsButton = true
        return searchBar
    }()

    // 검색 결과 컬렉션뷰
    lazy var searchResultCollectionView: BookListCollectionView = {
        let collectionView = BookListCollectionView()
        collectionView.register(SearchResultCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultCollectionViewHeader.id)
        return collectionView
    }()

    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 내역이 없습니다."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

    // TODO: - 검색 결과 리스트 (컬렉션뷰)

    // MARK: - 초기화

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        backgroundColor = .white

        [
            bookSearchBar,
            searchResultCollectionView,
            emptyLabel
        ].forEach {
            addSubview($0)
        }

        bookSearchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide.snp.horizontalEdges).inset(15)
        }

        searchResultCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookSearchBar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension SearchView {
    func configureLayout(_ searchResultIsEmpty: Bool) {
        if searchResultIsEmpty {
            searchResultCollectionView.isHidden = true
            emptyLabel.isHidden = false
        } else {
            searchResultCollectionView.isHidden = false
            emptyLabel.isHidden = true
        }
    }
}
