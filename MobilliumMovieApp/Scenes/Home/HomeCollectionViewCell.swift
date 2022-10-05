//
//  HomeCollectionViewCell.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import UIKit
import Kingfisher

final class HomeCollectionViewCell: UICollectionViewCell, Layoutable {
    
    // MARK: - Initilization
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieShortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(movieShortDescriptionLabel)
        
    }
    
    func setupLayout() {
        movieImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredSpacing * 9)
            make.leading.equalToSuperview().inset(preferredSpacing * 0.8)
        }
        
        movieShortDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(preferredSpacing * 0.8)
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(preferredSpacing * 0.4)
        }
    }
}
// MARK: - Configure
extension HomeCollectionViewCell {
    func configure(movie: Result) {
        movieImageView.kf.indicatorType = .activity
        guard let path = movie.backdropPath else {
            movieImageView.image = UIImage(named: "placeHolder")
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: path))")
        movieImageView.kf.setImage(with: url)
        movieTitleLabel.text = "\(movie.title) (\(movie.releaseDate.dropLast(6)))"
        movieShortDescriptionLabel.text = movie.overview
    }
}
