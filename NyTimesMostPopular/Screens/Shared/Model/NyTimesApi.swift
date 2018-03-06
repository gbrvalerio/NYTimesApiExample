//
//  NyTimesApi.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

enum NewsTimePeriod : Int {
    case day = 1
    case week = 7
    case month = 30
}

class NyTimesApi {
    
    typealias FetchSuccessCallback = (NyTimesApiResultModel) -> Void
    typealias FetchErrorCallback = (Error?) -> Void
    
    private static let apiKey = "b1d8ecd55a9f45c39f96ff25b8002800"
    
    func fetchMostViewed(section:NewsSection, timePeriod:NewsTimePeriod, onSuccess:@escaping FetchSuccessCallback, onError: @escaping FetchErrorCallback) {
        guard let url = NyTimesApi.apiUrl(section: section, timePeriod: timePeriod) else {
            onError(nil)
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            guard
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let jsonData = data
            else {
                onError(error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(NyTimesApiResultModel.self, from: jsonData)
                onSuccess(result)
            } catch let decodeError {
                onError(decodeError)
            }
        }).resume()
    }
    
    private static func apiUrl(section:NewsSection, timePeriod:NewsTimePeriod) -> URL? {
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/\(section.rawValue)/\(timePeriod.rawValue).json?api-key=\(apiKey)"
        return URL(string: urlString)
    }
    
}
