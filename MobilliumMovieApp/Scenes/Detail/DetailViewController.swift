//
//  DetailViewController.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import UIKit

final class DetailViewController: UIViewController, Layouting, AlertShowing {
    // MARK: - Initialization
    typealias ViewType = DetailView
    
    private let movieDetailViewModel = DetailViewModel()
    
    override func loadView() {
        view = ViewType.create()
    }
    
    private var movie: Result?
    
    convenience init(movie: Result?) {
        self.init()
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailViewModel.delegate = self
        movieDetailViewModel.fetchNowPlayingMovies(movie?.id ?? 0)
        setupView()
    }
}
// MARK: - SetupHelper
extension DetailViewController {
    func setupView() {
        navigationController?.navigationBar.isHidden = false
        title = movie?.title
    }
}
// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func loading(isLoading: Bool) {
        self.layoutableView.setLoading(isLoading)
    }
    
    func onSuccessfullyMovieDetailLoaded() {
        guard let movieDetail = movieDetailViewModel.movieDetail else { return }
        self.layoutableView.configure(movie: movieDetail)
    }
    
    func onError(message: String) {
        self.showAlert(title: Strings.appTitle, message: message)
    }

}
