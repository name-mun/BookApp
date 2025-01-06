//
//  SearchResultCollectionViewHeader.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

class SearchResultCollectionViewHeader: UICollectionReusableView {

    static let id = "SearchResultCollectionViewHeader"

    // MARK: - UI 컴포넌트

    // 섹션 제목 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()

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
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
        }
    }

    // MARK: - 데이터 설정

    func configure(_ title: String) {
        titleLabel.text = title
    }
}
