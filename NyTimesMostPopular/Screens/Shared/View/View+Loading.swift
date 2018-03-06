//
//  View+Loading.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 06/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

private let kLoadingViewTag = 13131
private let kLoadingViewBackgroundColor = UIColor(white: 0.5, alpha: 0.5)

extension UIView {
    
    var loadingView:UIView? {
        return viewWithTag(kLoadingViewTag)
    }
    
    func startLoading() {
        let loadingView = UIView()
        loadingView.tag = kLoadingViewTag
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = kLoadingViewBackgroundColor
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        loadingView.addSubview(spinner)
        addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            loadingView.leftAnchor.constraint(equalTo: leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: rightAnchor),
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
        }
    }
    
}
