//
//  NewsPresenter.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

class NewsPresenter {
    
    weak private var view:NewsPresenterView?
    private let api = NyTimesApi()
    
    private var presentingNews:[NewsModel] = []
    
    init(view:NewsPresenterView) {
        self.view = view
    }
    
    func present() {
        view?.startLoading()
        
        api.fetchMostViewed(section: .blogs, timePeriod: .month, onSuccess: didFetchApi) { (error) in
            self.view?.stopLoading()
            self.view?.showConnectionErrorMessage()
        }
    }
    
    func didFetchApi(_ result:NyTimesApiResultModel) {
        guard result.status == "OK" else {
            return
        }
        
        presentingNews = result.news
        let viewModelNews = presentingNews.map { $0.viewModel }
        
        guard !viewModelNews.isEmpty else {
            view?.stopLoading()
            view?.showEmptyMessage()
            return
        }
        
        view?.show(news: viewModelNews)
        view?.stopLoading()
    }
    
}
