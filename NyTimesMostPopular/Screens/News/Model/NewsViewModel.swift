//
//  NewsViewModel.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

struct NewsViewModel {
    
    let title:String
    let byline:String
    let publishDate:String
    let thumbnailMetadata:NewsMediaMetadataImageModel?
    
}

extension NewsModel {
    
    var firstMediaImage:NewsMediaImageModel? {
        return media.first { media in media.type == kNewsMediaImageType }
    }
    
    var viewModel:NewsViewModel {
        let thumbnailMedatada = firstMediaImage?.metadata.first(where: { $0.format == .thumbnail })
        return NewsViewModel(title: title, byline: byline, publishDate: publishDate, thumbnailMetadata: thumbnailMedatada)
    }
    
}
