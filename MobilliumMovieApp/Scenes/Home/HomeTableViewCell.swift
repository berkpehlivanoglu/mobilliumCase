//
//  HomeTableViewCell.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import UIKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell, Layoutable {
    
    // MARK: - Initilization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieShortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    func setupViews() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(movieShortDescriptionLabel)
        addSubview(releaseDateLabel)

    }

    func setupLayout() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredSpacing * 0.8)
            make.leading.equalToSuperview()
            make.height.width.equalTo(104)
        }

        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieImageView.snp.trailing).offset(preferredSpacing * 0.4)
            make.width.equalTo(preferredSpacing * 10.2)
            make.top.equalToSuperview().inset(preferredSpacing * 1.2)
        }
        
        movieShortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(preferredSpacing * 0.4)
            make.leading.equalTo(movieImageView.snp.trailing).offset(preferredSpacing * 0.4)
            make.trailing.equalToSuperview().inset(preferredSpacing * 2.2)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(movieImageView.snp.bottom)
            make.trailing.equalToSuperview().inset(preferredSpacing * 2.2)
        }
        
    }
}

// MARK: - Configure
extension HomeTableViewCell {
    func configure(movie: Result) {
        movieImageView.kf.indicatorType = .activity
        guard let path = movie.posterPath else {
            movieImageView.image = UIImage(named: "placeHolder")
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: path))")
        movieImageView.kf.setImage(with: url)
        movieTitleLabel.text = "\(movie.title) (\(movie.releaseDate.dropLast(6)))"
        movieShortDescriptionLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
    }
}
