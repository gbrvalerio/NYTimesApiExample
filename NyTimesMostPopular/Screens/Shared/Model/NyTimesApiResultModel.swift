//
//  NyTimesApiResult.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

///Api result swift model for the NY Times api
/// /mostviewed/{section}/{time-period}.json
/// Result:
///{
///    "status": "string",
///    "copyright": "string",
///    "num_results": 0,
///    "results": [
///        {
///        "url": "string",
///        "column": "string",
///        "section": "string",
///        "byline": "string",
///        "title": "string",
///        "abstract": "string",
///        "published_date": "string",
///        "source": "string",
///        "des_facet": {},
///        "org_facet": {},
///        "per_facet": {},
///        "geo_facet": {}
///        }
///    ]
///}
struct NyTimesApiResultModel : Decodable {
    ///The result status message
    let status:String
    ///The NY Times copyright
    let copyright:String
    ///The number of results/news fetched
    let numberOfNews:Int
    ///All the news resulted from query
    let news:[NewsModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(String.self, forKey: .status)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.numberOfNews = try container.decode(Int.self, forKey: .numberOfNews)
        self.news = (try? container.decode([NewsModel].self, forKey: .news)) ?? []
    }
    
    private enum CodingKeys : String, CodingKey {
        case status
        case copyright
        case numberOfNews = "num_results"
        case news = "results"
    }
    
}
