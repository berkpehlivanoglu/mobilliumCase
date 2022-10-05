//
//  HomeView.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//
import UIKit

final class HomeView: UIView, Layoutable, Loadingable {
    
    // MARK: - Properties
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let width = UIScreen.main.bounds.size.width
        layout.itemSize = CGSize(width: width, height: width * 0.92)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "homeCollectionCell")
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 5
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeTableCell")
        tableView.keyboardDismissMode = .interactive
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(pageControl)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.addSubview(contentView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Setups
    func setupViews() {
        backgroundColor = .white
        addSubview(scrollView)
        
    }
    
    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(3020)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(preferredSpacing * 12.8)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(preferredSpacing * 2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(preferredSpacing)
            make.bottom.equalToSuperview()
        }
    }
}
