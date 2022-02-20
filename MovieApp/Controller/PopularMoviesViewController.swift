//
//  PopularMoviesViewController.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    private enum AccessibilityIdentifiers {
        static let popularMovieTableView = "popularMovieTableView"
    }
    
    var viewModel: PopularMoviesViewModel?
    var movieList: [Movie]?
    @IBOutlet var tableView: UITableView!
    weak var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movie"
        setupUI()
        setupAccessibilityIdentifiers()
        // Do any additional setup after loading the view.
        viewModel = PopularMoviesViewModel()
        bindViewModel()
        reloadMovies()
    }
    
    func setupUI() {
        self.tableView.separatorStyle   = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PopularMovieCell", bundle: nil), forCellReuseIdentifier: "PopularMovieCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle =
            NSAttributedString(string: "Pull To Refresh",
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        refreshControl.addTarget(self, action: #selector(reloadMovies), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        self.refreshControl = refreshControl
    }
    
    func setupAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = AccessibilityIdentifiers.popularMovieTableView
    }
    
    @objc func reloadMovies() {
        viewModel?.reloadMovies()
    }
    
    func bindViewModel() {
        viewModel?.onChange = viewModelStateChange
    }
    
    func viewModelStateChange(change: MovieListState.Change) {
        switch change {
        case .none:
            break
        case .fetchStateChanged:
            if let movies =  viewModel?.state.movies, !movies.isEmpty {
                movieList = movies
                tableView.reloadData()
                break
            }
            tableView.reloadData()
            break
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                tableView.applyCollectionChange(collectionChange,
                                                toSection: 0,
                                                withAnimation: .fade)
            default:
                tableView.beginUpdates()
                if !(viewModel?.state.page.hasNextPage ?? false) {
                    tableView.applyCollectionChange(CollectionChange.deletion(0),
                                                    toSection: 0,
                                                    withAnimation: .fade)
                }
                tableView.applyCollectionChange(collectionChange,
                                                toSection: 0,
                                                withAnimation: .fade)
                tableView.endUpdates()
            }
        case .error(let movieError) :
            switch movieError {
            case .connectionError(_):
                Alert.present(withTitle: "Connection Error", description: "Check your network status and pull to refresh", from: self)
            case .mappingFailed:
                Alert.present(withTitle: "Invalid Data", description: "There is an error when getting data from server. Please pull to refresh", from: self)
            case .reloadFailed:
                Alert.present(withTitle: "Invalid Data", description: "There is an error when getting data from server. Please pull to refresh", from: self)
            }
            break
        }
        refreshControl?.endRefreshing()
    }
}

extension PopularMoviesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.state.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let popularMovieCell: PopularMovieCell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieCell", for: indexPath as IndexPath) as? PopularMovieCell else {
            fatalError("PopularMovieCell cell is not found")
        }
        if let movie = movieList?[indexPath.row]{
            popularMovieCell.viewBindableModel = movie
        }
        return popularMovieCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let viewModel = viewModel, viewModel.state.page.hasNextPage,
           indexPath.row == (viewModel.state.movies.count - 2) {
            viewModel.loadMoreMovies()
        }
    }
    
}
