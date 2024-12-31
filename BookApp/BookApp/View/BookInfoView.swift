//
//  BookInfoView.swift
//  BookApp
//
//  Created by mun on 12/31/24.
//

import UIKit

import SnapKit

class BookInfoView: UIView {

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
    }

}
