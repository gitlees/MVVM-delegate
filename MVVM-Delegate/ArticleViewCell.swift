//
//  CollectionViewCell.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/24/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import UIKit

final class ArticleViewCell: BaseCell {
    
    // MARK: - UI Components
        
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 1.0)
        return view
    }()
    
    // MARK: - Con(De)structor
    
    override func setupViews() {
        setProperties()
        
        contentView.addSubviews(titleLabel, descriptionLabel, lineView)
        layout()
        
    }
    
    override func reset() {
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    // MARK: - Internal methods
    
    func configure(with model: Article) {
        titleLabel.text = model.title
        descriptionLabel.text = model.body
    }
    
    // MARK: - Private methods
    

    
    private func setProperties() {
        
    }
    
}

// MARK: - Layout

extension ArticleViewCell {
    
    private func layout() {

        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5)
        ]
        
        let lineViewConstraints = [
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ]
        NSLayoutConstraint.activate(
            titleLabelConstraints +
            descriptionLabelConstraints +
            lineViewConstraints
        )

    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }
    
}
