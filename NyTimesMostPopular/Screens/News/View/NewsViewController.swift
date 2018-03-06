//
//  NewsViewController.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, NewsPresenterView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    private var actualDisplayingNews:[NewsViewModel] = []
    private lazy var presenter = NewsPresenter(view: self)

    //MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        presenter.present()
    }
    
    //MARK: - Presentations
    
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
        view.startLoading()
    }
    
    ///Tells the view to dismiss any possible loading indicator.
    func stopLoading() {
        view.stopLoading()
    }
    
    ///Tells the view to show the connection error message.
    func showConnectionErrorMessage() {
        let alert = UIAlertController(title: "Connection error!", message: "It was not possible to connect to the NYTimes API!", preferredStyle: .alert)
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

}
