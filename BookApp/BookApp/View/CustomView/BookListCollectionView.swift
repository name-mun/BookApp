//
//  SearchResultCollectionView.swift
//  BookApp
//
//  Created by mun on 1/2/25.
//

import UIKit

import SnapKit

class BookListCollectionView: UICollectionView {

    // MARK: - 초기화

    convenience init() {
        self.init(frame: .zero, collectionViewLayout: .init())
        setupCollectionView()
    }

    // MARK: - 초기 설정

    private func setupCollectionView() {
        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.showsVerticalScrollIndicator = false
        self.register(RecentBookCollectionViewCell.self, forCellWithReuseIdentifier: RecentBookCollectionViewCell.id)
        self.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.id)
    }

    // 헤더 레이아웃 생성
    private func createLayoutForHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        return header
    }

    // 최근 본 책 레이아웃 설정
    private func createLayoutForRecentBook() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(70),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    // 검색 결과, 담은 책 레이아웃 설정
    private func createLayoutForSearchResult() -> NSCollectionLayoutSection {
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

        return section
    }
}

// MARK: - View 레이아웃 설정

extension BookListCollectionView {

    // savedView Layout 설정
    func savedViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: createLayoutForSearchResult()) // 헤더 없는 레이아웃
    }

    // searchView 설정
    func searchViewLayout(recentBookIsEmpty: Bool, searchResultIsEmpty: Bool) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviroment in
            guard let self = self else { return nil }

            if Section(rawValue: sectionIndex) == .recentBook {
                let newSection = createLayoutForRecentBook()
                // 아이템이 있는 경우에만 헤더 영역 레이아웃 생성
                if !recentBookIsEmpty {
                    newSection.boundarySupplementaryItems = [createLayoutForHeader()]
               }
                return newSection
            } else {
                let newSection = createLayoutForSearchResult()
                if !searchResultIsEmpty {
                    newSection.boundarySupplementaryItems = [createLayoutForHeader()]
                }
                return newSection
            }
        }
    }
}
