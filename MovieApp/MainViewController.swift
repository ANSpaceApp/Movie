//
//  MainViewController.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import UIKit


protocol PresenterViewType: class {
    func show(moviews: [UpcomingMovie], totalPages: Int)
    func activityIndicatorStartAnimating()
    func acitivtyIndicatorStopAnimating()
}

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var searchController: UISearchController!
    var presenter: UpcomingMoviesPresenter?
    private var moviesData = [UpcomingMovie]()
    private var searchArray = [UpcomingMovie]()
    private var page = 1
    private var totalPages = 0
    private var cellHeights: [IndexPath : CGFloat] = [:]
    private var currentSearchString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        presenter = UpcomingMoviesPresenter(view: self)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти фильм"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.barStyle = .black
        presenter?.activityIndicatorStartAnimating()
        presenter?.getMoviewFeed(withPage: String(page))
        
        setupTableView()
    }
  
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.topItem?.title = "Скоро в кино"
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = tableViewBackgroundColor
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.setContentOffset(tableView.contentOffset, animated: false)
        tableView.register(UpcomingMoviesTableViewCell.self)
    }
    

}
extension MainViewController: PresenterViewType {
    
    func show(moviews: [UpcomingMovie], totalPages: Int) {
        moviesData += moviews
        
        self.totalPages = totalPages
        presenter?.activityIndicatorStopAnimating()
        tableView.reloadData()
    }
    
    func activityIndicatorStartAnimating() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func acitivtyIndicatorStopAnimating() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension MainViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchArray.count
        } else {
            return moviesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UpcomingMoviesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model =  (searchController.isActive) ? searchArray[indexPath.row] : moviesData[indexPath.row]
        cell.configureSelf(withModel: model)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model =  (searchController.isActive) ? searchArray[indexPath.row] : moviesData[indexPath.row]
        performSegue(withIdentifier: "viewDetail", sender: model)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDetail" {
            let destination = segue.destination as! DetailViewController
            if let sendModel = sender as? UpcomingMovie {
                destination.detailModel = sendModel
            }
    }
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 150.0 }
        return height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
        if indexPath.row == moviesData.count - 1  && page < totalPages + 1  {
            page += 1
            presenter?.getMoviewFeed(withPage: String(page))
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if let urlEncodedString = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) {
                currentSearchString = urlEncodedString
                fetchDataUI(searchText: urlEncodedString)
                tableView.reloadData()
            }
        }
    }
}
extension MainViewController {
    func fetchDataUI(searchText: String) {
        let jsonURL = "http://api.themoviedb.org/3/search/movie?api_key=2a2e3cdc92bf1bdb6df865c4af82168e&query=\(searchText)&language=ru"
        print(jsonURL)
        DataProvider.fetchData(url: jsonURL) { (searchArray) in
            self.searchArray = searchArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
    }
}
