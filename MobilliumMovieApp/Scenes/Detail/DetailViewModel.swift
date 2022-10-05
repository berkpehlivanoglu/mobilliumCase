//
//  DetailViewModel.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 5.10.2022.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func loading(isLoading: Bool)
    func onSuccessfullyMovieDetailLoaded()
    func onError(message: String)
}

class DetailViewModel {
    private(set) var movie: Result?
    private(set) var movieDetail: MovieDetail?
    
    public weak var delegate: DetailViewModelDelegate?
    
    func fetchNowPlayingMovies(_ id: Int) {
        self.delegate?.loading(isLoading: true)
        API.movieProvider.request(.showDetail(id: id)) { [weak self] result in
            
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
                guard let data = try? response.map(MovieDetail.self) else {
                    return
                }
                self.movieDetail = data
                DispatchQueue.main.async {
                    self.delegate?.onSuccessfullyMovieDetailLoaded()
                }
                
            }
        }
    }
    
}
