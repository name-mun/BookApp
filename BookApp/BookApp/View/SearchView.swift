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

    private let searchResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        return label
    }()

    lazy var SearchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
        return collectionView
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
            searchResultLabel,
            SearchResultCollectionView
        ].forEach {
            addSubview($0)
        }

        bookSearchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide.snp.horizontalEdges).inset(15)
        }

        searchResultLabel.snp.makeConstraints {
            $0.top.equalTo(bookSearchBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
        }

        SearchResultCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }

    private func createLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
