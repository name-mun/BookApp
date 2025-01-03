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

    convenience init(_ sectionCount: Int) {
        self.init(frame: .zero, collectionViewLayout: .init())
        setupCollectionView(sectionCount)
    }

    // MARK: - 초기 설정

    private func setupCollectionView(_ sectionCount: Int) {
        self.collectionViewLayout = createLayout(sectionCount)
        self.showsVerticalScrollIndicator = false
        self.register(RecentBookCollectionViewCell.self, forCellWithReuseIdentifier: RecentBookCollectionViewCell.id)
        self.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.id)
    }

    private func createLayout(_ sectionCount: Int) -> UICollectionViewLayout {
        if sectionCount == 1 {
            return UICollectionViewCompositionalLayout(section: createLayoutForSearchResult())
        } else {
            return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviroment in
                guard let self = self else { return nil }
                let section = Section(rawValue: sectionIndex)

                switch section {
                case .recentBook:
                    print("recentBook")
                    let onlySection = createLayoutForRecentBook()
                    onlySection.boundarySupplementaryItems = [createLayoutForHeader()]
                    return onlySection
                case .searchResult:
                    let onlySection = createLayoutForSearchResult()
                    onlySection.boundarySupplementaryItems = [createLayoutForHeader()]
                    return onlySection
                default: return nil
                }
            }
        }
    }

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

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    
}
