//
//  HomeViewController.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import UIKit
import Moya

final class HomeViewController: UIViewController, Layouting, AlertShowing {
    
    typealias ViewType = HomeView
    
    private let moviesViewModel = HomeViewModel()
    var page = 1
    
    override func loadView() {
        view = ViewType.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel.delegate = self
        moviesViewModel.fetchUpComingMovies(page)
        moviesViewModel.fetchNowPlayingMovies(page)
        setupPageControl()
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViews()
    }
    
}
// MARK: - SetupViews
extension HomeViewController {
    func setupViews() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
}
// MARK: - SetupPageControl
extension HomeViewController {
    func setupPageControl() {
        layoutableView.pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .touchUpInside)
    }
    
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        let index = sender.currentPage + 1
        guard let rect = layoutableView.collectionView.layoutAttributesForItem(at: IndexPath(row: index, section: 0))?.frame else { return }
        layoutableView.collectionView.scrollRectToVisible(rect, animated: true)
        
    }

}
// MARK: - SetupRefreshControl
extension HomeViewController {
    func configureRefreshControl() {
        layoutableView.scrollView.refreshControl = UIRefreshControl()
        layoutableView.scrollView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        page += 1
        moviesViewModel.fetchUpComingMovies(page)
        moviesViewModel.fetchNowPlayingMovies(page)
       DispatchQueue.main.async {
           self.layoutableView.scrollView.refreshControl?.endRefreshing()
       }
    }

}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let upcomingMovies = moviesViewModel.upcomingMovies[indexPath.row]
        cell.configure(movie: upcomingMovies)
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard moviesViewModel.upcomingMovies.count > 0 else { return }
        let movieDetailViewController = DetailViewController(movie: moviesViewModel.upcomingMovies[indexPath.row])
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        let nowPlayingMovies = moviesViewModel.nowPlayingMovies[indexPath.row]
        cell.configure(movie: nowPlayingMovies)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard moviesViewModel.nowPlayingMovies.count > 0 else { return }
        let movieDetailViewController = DetailViewController(movie: moviesViewModel.nowPlayingMovies[indexPath.item])
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        layoutableView.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        layoutableView.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}
// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func loading(isLoading: Bool) {
        self.layoutableView.setLoading(isLoading)
    }
    
    func onSuccessfullyNowPlayingMoviesLoaded() {
        self.layoutableView.collectionView.delegate = self
        self.layoutableView.collectionView.dataSource = self
        self.layoutableView.collectionView.reloadData()
    }
    
    func onSuccessfullyUpComingMoviesLoaded() {
        self.layoutableView.tableView.delegate = self
        self.layoutableView.tableView.dataSource = self
        self.layoutableView.tableView.reloadData()
    }
    
    func onError(message: String) {
        self.showAlert(title: Strings.appTitle, message: message)
    }
    
}
