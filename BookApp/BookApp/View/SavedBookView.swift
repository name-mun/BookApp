//
//  SavedBookView.swift
//  BookApp
//
//  Created by mun on 1/2/25.
//

import UIKit

import SnapKit

class SavedBookView: UIView {

    // MARK: - UI 컴포넌트

    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    let allDeleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        return button
    }()

    let savedBookCollectionView = BookListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())


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
        [
            headerStackView,
            savedBookCollectionView
        ].forEach {
            addSubview($0)
        }

        [
            allDeleteButton,
            titleLabel,
            addButton
        ].forEach {
            headerStackView.addArrangedSubview($0)
        }

        headerStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(20)
        }

        allDeleteButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }

        addButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }

        savedBookCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
