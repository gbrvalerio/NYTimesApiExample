//
//  NewsViewController.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, NewsPresenterView, UITableViewDataSource, UITableViewDelegate {
    
    private var actualDisplayingNews:[NewsViewModel] = []

    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    //MARK: - Presentations
    
    ///Tells the view to display the news.
    func show(news:[NewsViewModel]) {
        self.actualDisplayingNews = news
        newsTableView.reloadData()
    }
    
    ///Tells the view to display the message for no avaliable news.
    func showEmptyMessage() {
        
    }
    
    ///Tells the view to display a loading indicator.
    func startLoading() {
        
    }
    
    ///Tells the view to dismiss any possible loading indicator.
    func stopLoading() {
        
    }
    
    ///Tells the view to show the connection error message.
    func showConnectionErrorMessage() {
        
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
