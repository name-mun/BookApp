//
//  BookInfoView.swift
//  BookApp
//
//  Created by mun on 12/31/24.
//

import UIKit

import SnapKit

class BookInfoView: UIView {

    // MARK: - UI 컴포넌트

    // 책 정보 스크롤뷰
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // 컨텐트뷰
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    // 제목 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()

    // 저자 라벨
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // 이미지 뷰
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        return imageView
    }()

    // 가격 라벨
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    // 내용 라벨
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    // 버튼 스택뷰
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()

    // 닫기 버튼
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        return button
    }()

    // 담기 버튼
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        return button
    }()

    // MARK: - 생명주기 메서드

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
            scrollView,
            buttonStackView
        ].forEach {
            addSubview($0)
        }

        scrollView.addSubview(contentView)

        [
            titleLabel,
            authorLabel,
            thumbnailImageView,
            priceLabel,
            contentsLabel
        ].forEach {
            contentView.addSubview($0)
        }

        [closeButton, saveButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-25)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }

        authorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(authorLabel.snp.bottom).offset(15)
            $0.height.equalTo(300)
            $0.width.equalTo(200)
        }

        priceLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(15)
        }

        contentsLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(priceLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }

        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }

        closeButton.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }

    // MARK: - 데이터 설정

    func configureData(_ book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.authors?.first
        priceLabel.text = PriceFormatterModel.wonFormatter(book.price ?? 0)
        contentsLabel.text = book.contents

    }

    func configureImage(_ image: UIImage) {
        thumbnailImageView.image = image
    }

}
