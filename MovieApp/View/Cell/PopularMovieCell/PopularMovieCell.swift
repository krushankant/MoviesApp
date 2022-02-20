//
//  PopularMovieCell.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import UIKit
import Kingfisher

class PopularMovieCell: BaseTableViewCell {
    
    private enum AccessibilityIdentifiers {
        static let popularMovieView = "popularMovieView"
        static let movieTitleLable = "movieTitleLable"
        static let movieReleaseDateLable = "movieReleaseDateLable"
        static let moviePosterImage = "moviePosterImage"
    }
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var releaseDateLable: UILabel!
    @IBOutlet fileprivate var posterImageView: UIImageView! {
        didSet {
            if let imageView = posterImageView {
                imageView.kf.indicatorType = .activity
            }
        }
    }
    
    override var viewBindableModel: ViewBindable? {
        didSet {
            guard let bindable = viewBindableModel else {
                return
            }
            titleLabel.text = bindable.getTitle()
            releaseDateLable.text = bindable.getSubtitle()
            if let url = bindable.getImageURL() {
                posterImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: nil, completionHandler:  { result in
                        switch result {
                        case .success(let value):
                            print("Movie Image download using url: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            print("Movie Image download failed: \(error.localizedDescription)")
                        }
                    })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCellUI()
        selectionStyle = .none
        setupAccessibilityIdentifiers()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        releaseDateLable.text = nil
        posterImageView.image = nil
        posterImageView.kf.cancelDownloadTask()
    }
}

extension PopularMovieCell {
    func setupCellUI() {
        posterImageView.layer.borderWidth = 0.3
        posterImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupAccessibilityIdentifiers() {
        self.accessibilityIdentifier = AccessibilityIdentifiers.popularMovieView
        titleLabel.accessibilityIdentifier = AccessibilityIdentifiers.movieTitleLable
        releaseDateLable.accessibilityIdentifier = AccessibilityIdentifiers.movieReleaseDateLable
        posterImageView.accessibilityIdentifier = AccessibilityIdentifiers.moviePosterImage
    }
}
