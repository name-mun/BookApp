//
//  searchResultCollectionViewCell.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import UIKit

import SnapKit

class RecentBookCollectionViewCell: UICollectionViewCell {

    static let id = "RecentBookCollectionViewCell"

    // MARK: - UI 컴포넌트

    // 이미지 뷰
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 70 / 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
        [
            thumbnailImageView
        ].forEach {
            addSubview($0)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - 데이터 설정

    func configure(_ image: UIImage?) {
        // 이미지 설정
        guard let image = image else { return }

        thumbnailImageView.image = image
    }
}
