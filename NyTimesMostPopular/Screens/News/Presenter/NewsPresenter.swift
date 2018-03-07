//
//  NewsPresenter.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

class NewsPresenter {
    
    weak private var view:NewsPresenterView?
    private let api = NyTimesApi()
    
    private var presentingNews:[NewsModel] = []
    
    private var presentingSection:NewsSection = .all
    private var presentingTimePeriod:NewsTimePeriod = .week
    private var shouldFetchApi:Bool = false
    
    ///Default initializer
    init(view:NewsPresenterView) {
        self.view = view
    }
    
    ///Starts the presentations
    func present() {
        fetchApi()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let filterVc = (segue.destination as? UINavigationController)?.topViewController as? NewsFilterViewController {
            filterVc.selectedSection = self.presentingSection
            filterVc.selectedTimePeriod = self.presentingTimePeriod
            filterVc.onUserDidUpdateFilter = self.onUserDidFilter
            filterVc.onDismiss = self.onFilterDismissed
        }
    }
    
    private func fetchApi() {
        view?.startLoading()
        
        api.fetchMostViewed(section: presentingSection, timePeriod: presentingTimePeriod, onSuccess: didFetchApi) { (error) in
            self.view?.stopLoading()
            self.view?.showConnectionErrorMessage()
        }
    }
    
    private func didFetchApi(_ result:NyTimesApiResultModel) {
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
    
    //MARK: - User Input
    
    ///Called whenver the user inputs a refresh
    func onUserWantsToRefresh() {
        fetchApi()
    }
    
    //Called whenever the user picks any new filtering options
    func onUserDidFilter(_ section:NewsSection, _ timePeriod:NewsTimePeriod) {
        self.presentingSection = section
        self.presentingTimePeriod = timePeriod
        
        shouldFetchApi = true
    }
    
    //Called whenever the filter screen is dismissed
    func onFilterDismissed() {
        if shouldFetchApi {
            fetchApi()
            shouldFetchApi = false
        }
    }
}
