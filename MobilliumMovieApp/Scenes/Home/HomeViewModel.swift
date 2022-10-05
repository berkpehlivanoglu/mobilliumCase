//
//  HomeViewModel.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 5.10.2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func loading(isLoading: Bool)
    func onSuccessfullyNowPlayingMoviesLoaded()
    func onSuccessfullyUpComingMoviesLoaded()
    func onError(message: String)
}

class HomeViewModel {
    private(set) var nowPlayingMovies: [Result] = []
    private(set) var upcomingMovies: [Result] = []
    
    public weak var delegate: HomeViewModelDelegate?
    
    func fetchNowPlayingMovies(_ page: Int) {
        self.delegate?.loading(isLoading: true)
        API.movieProvider.request(.nowPlaying(page: page)) { [weak self] result in
            
            guard let self = self else { return }
            self.delegate?.loading(isLoading: false)
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.onError(message: error.localizedDescription)
            case .success(let response):
                
                if let errorData = try? response.map(Error.self) {
                    self.delegate?.onError(message: errorData.statusMessage)
                    return
                }
                guard let data = try? response.map(Movie.self) else {
                    return
                }
                self.nowPlayingMovies = data.results
                DispatchQueue.main.async {
                    self.delegate?.onSuccessfullyNowPlayingMoviesLoaded()
                }
                
            }
        }
    }
    
    func fetchUpComingMovies(_ page: Int) {
        self.delegate?.loading(isLoading: true)
        API.movieProvider.request(.upComing(page: page)) { [weak self] result in
            
            guard let self = self else { return }
            self.delegate?.loading(isLoading: false)
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.onError(message: error.localizedDescription)
            case .success(let response):
                
                if let errorData = try? response.map(Error.self) {
                    self.delegate?.onError(message: errorData.statusMessage)
                    return
                }
                guard let data = try? response.map(Movie.self) else {
                    return
                }
                self.upcomingMovies = data.results
                DispatchQueue.main.async {
                    self.delegate?.onSuccessfullyUpComingMoviesLoaded()
                }
                
            }
        }
    }
    
}
