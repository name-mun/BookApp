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
        addSubview(bookSearchBar)

        bookSearchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide.snp.horizontalEdges).inset(15)
        }
    }
}
