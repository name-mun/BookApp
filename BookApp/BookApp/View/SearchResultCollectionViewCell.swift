//
//  searchResultCollectionViewCell.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    static let id = "SearchResultCollectionViewCell"

    // MARK: - UI 컴포넌트

    // 제목 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // 저자 라벨
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()

    // 가격 라벨
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .right
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
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor

        [
            titleLabel,
            authorLabel,
            priceLabel
        ].forEach {
            addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(180)
        }

        authorLabel.snp.makeConstraints {
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }


    }

    // MARK: - 데이터 설정

    func configure(_ book: Book) {
        // 제목 설정
        if let title = book.title {
            titleLabel.text = title
        }

        // 저자 설정
        if let authors = book.authors {
            authorLabel.text = authors.first
        }

        // 가격 설정
        if let price = book.price {
            priceLabel.text = PriceFormatterModel.wonFormatter(price)
        }
    }
}
