//
//  NewsPresenterView.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

protocol NewsPresenterView : class {
    
    ///Tells the view to display the news.
    func show(news:[NewsViewModel])
    ///Tells the view to display the message for no avaliable news.
    func showEmptyMessage()
    ///Tells the view to display a loading indicator.
    func startLoading()
    ///Tells the view to dismiss any possible loading indicator.
    func stopLoading()
    ///Tells the view to show the connection error message.
    func showConnectionErrorMessage()
    
}
