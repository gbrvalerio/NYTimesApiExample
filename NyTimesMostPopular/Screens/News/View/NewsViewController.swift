//
//  NewsViewController.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

private let kNewsCellHeight:CGFloat = 110.0

class NewsViewController: UIViewController, NewsPresenterView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    private var actualDisplayingNews:[NewsViewModel] = []
    private lazy var presenter = NewsPresenter(view: self)

    //MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        configurePullToRefresh()
        
        presenter.present()
    }
    
    private func configurePullToRefresh() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(self.onRefresh), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            newsTableView.refreshControl = refreshControl
        } else {
            newsTableView.addSubview(refreshControl)
        }
    }
    
    //MARK: - User Input
    @objc private func onRefresh(_ sender:Any?) {
        presenter.onUserWantsToRefresh()
    }
    
    //MARK: - Presentations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //proxying to presenter
        presenter.prepare(for: segue, sender: sender)
    }
    
    ///Tells the view to display the news.
    func show(news:[NewsViewModel]) {
        self.actualDisplayingNews = news
        
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    ///Tells the view to display the message for no avaliable news.
    func showEmptyMessage() {
        let alert = UIAlertController(title: "No results!", message: "No result was found for your search parameters!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    ///Tells the view to display a loading indicator.
    func startLoading() {
        let isIdle = !(newsTableView.refreshControl?.isRefreshing ?? true)
        guard isIdle else { return }
        
        let refreshControlHeight = self.newsTableView.refreshControl?.frame.height ?? 0.0
        DispatchQueue.main.async {
            self.newsTableView.setContentOffset(CGPoint(x: 0, y: -refreshControlHeight), animated: true)
            self.newsTableView.refreshControl?.beginRefreshing()
        }
    }
    
    ///Tells the view to dismiss any possible loading indicator.
    func stopLoading() {
        DispatchQueue.main.async {
            self.newsTableView.refreshControl?.endRefreshing()
        }
    }
    
    ///Tells the view to show the connection error message.
    func showConnectionErrorMessage() {
        let alert = UIAlertController(title: "Api error!", message: "It was not possible to connect/fulfill your request to the NYTimes API!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Tableview protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualDisplayingNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        let news = actualDisplayingNews[indexPath.row]
        
        cell.newsTitle = news.title
        cell.newsByline = news.byline
        cell.newsPublishDate = news.publishDate
        cell.setThumbnail(url: news.thumbnailMetadata?.url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kNewsCellHeight
    }

}
