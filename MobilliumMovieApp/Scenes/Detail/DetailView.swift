//
//  DetailView.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import UIKit
import Kingfisher

final class DetailView: UIView, Layoutable, Loadingable {
    
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(movieImageView)
        view.addSubview(imdbLogoView)
        view.addSubview(starIconView)
        view.addSubview(movieRatingLabel)
        view.addSubview(circleImageView)
        view.addSubview(movieReleasedLabel)
        view.addSubview(movieNameLabel)
        view.addSubview(movieDescriptionLabel)
        view.alwaysBounceVertical = true
        view.isScrollEnabled = true
        return view
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imdbLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "imdbLogo")
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var starIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "rateIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var circleImageView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.imdbYellow
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var movieReleasedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // MARK: - Setups
    func setupViews() {
        backgroundColor = .white
        addSubview(scrollView)

    }

    func setupLayout() {
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        movieImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(preferredSpacing * 14)
        }
        
        imdbLogoView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(preferredSpacing * 0.8)
            make.leading.equalToSuperview().inset(preferredSpacing * 0.8)
            make.height.equalTo(preferredSpacing * 1.2)
            make.width.equalTo(preferredSpacing * 2.5)
        }
        
        starIconView.snp.makeConstraints { make in
            make.centerY.equalTo(imdbLogoView)
            make.leading.equalToSuperview().inset(preferredSpacing * 3.7)
            make.height.width.equalTo(preferredSpacing * 0.8)
        }
        
        movieRatingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imdbLogoView)
            make.leading.equalToSuperview().inset(preferredSpacing * 4.7)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.centerY.equalTo(imdbLogoView)
            make.height.width.equalTo(preferredSpacing * 0.2)
            make.leading.equalToSuperview().inset(preferredSpacing * 7)
        }
        
        movieReleasedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imdbLogoView)
            make.leading.equalToSuperview().inset(preferredSpacing * 7.6)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imdbLogoView.snp.bottom).offset(preferredSpacing * 0.8)
            make.leading.trailing.equalToSuperview().inset(preferredSpacing * 0.8)
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(preferredSpacing * 0.8)
            make.leading.trailing.equalToSuperview().inset(preferredSpacing * 0.8)
        }
    }
}

// MARK: - Configure
extension DetailView {

    func configure(movie: MovieDetail) {
        movieNameLabel.text = "\(movie.title) (\(movie.releaseDate.dropLast(6)))"
        movieReleasedLabel.text = movie.releaseDate
        movieDescriptionLabel.text = movie.overview
        let numberOfPlaces = 1.0
        let multiplier = pow(10.0, numberOfPlaces)
        let number = movie.voteAverage
        let roundedRaiting = round(number * multiplier) / multiplier
        movieRatingLabel.text = "\(roundedRaiting)/10"
        let path = movie.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        movieImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeHolder"))
    }
}
