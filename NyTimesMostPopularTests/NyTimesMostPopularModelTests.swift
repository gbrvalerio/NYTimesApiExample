//
//  NyTimesMostPopularTests.swift
//  NyTimesMostPopularTests
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import XCTest
@testable import NyTimesMostPopular

class NyTimesMostPopularModelTests: XCTestCase {
    
    let workingTestJson = """
        {
            "status": "OK",
            "copyright": "Copyright (c) 2018 The New York Times Company.  All Rights Reserved.",
            "num_results": 1,
            "results": [
                {
                    "url": "https://www.nytimes.com/2018/03/04/arts/oscar-winners.html",
                    "adx_keywords": "Academy Awards (Oscars);Movies",
                    "column": null,
                    "section": "Arts",
                    "byline": "Compiled by ANDREW R. CHOW",
                    "type": "Article",
                    "title": "The 2018 Oscar Winners: Full List",
                    "abstract": "The winners of the 90th annual Academy Awards.",
                    "published_date": "2018-03-04",
                    "source": "The New York Times",
                    "id": 100000005758750,
                    "asset_id": 100000005758750,
                    "views": 1,
                    "des_facet": [
                        "ACADEMY AWARDS (OSCARS)",
                        "MOVIES"
                    ],
                    "org_facet": "",
                    "per_facet": "",
                    "geo_facet": "",
                    "media": [
                        {
                            "type": "image",
                            "subtype": "photo",
                            "caption": "Jordan Peele wins best original screenplay at the 90th Academy Awards.",
                            "copyright": "Patrick T. Fallon for The New York Times",
                            "approved_for_syndication": 1,
                            "media-metadata": [
                                {
                                    "url": "https://static01.nyt.com/images/2018/03/05/arts/05WINNERSLISTPEELE/05WINNERSLISTPEELE-thumbStandard.jpg",
                                    "format": "Standard Thumbnail",
                                    "height": 75,
                                    "width": 75
                                },
                                {
                                    "url": "https://static01.nyt.com/images/2018/03/05/arts/05WINNERSLISTPEELE/merlin_135000468_74d754b3-870f-4a55-ad3d-50335896a674-mediumThreeByTwo210.jpg",
                                    "format": "mediumThreeByTwo210",
                                    "height": 140,
                                    "width": 210
                                },
                                {
                                    "url": "https://static01.nyt.com/images/2018/03/05/arts/05WINNERSLISTPEELE/merlin_135000468_74d754b3-870f-4a55-ad3d-50335896a674-mediumThreeByTwo440.jpg",
                                    "format": "mediumThreeByTwo440",
                                    "height": 293,
                                    "width": 440
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    """
    
    let emptyWorkingTestJson = """
        {
            "status": "OK",
            "copyright": "Copyright (c) 2018 The New York Times Company.  All Rights Reserved.",
            "num_results": 0,
            "results": []
        }
    """
    
    func testWorkingJson() {
        let jsonData = workingTestJson.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        
        let apiResult = try? jsonDecoder.decode(NyTimesApiResultModel.self, from: jsonData)
        let firstNews = apiResult?.news.first
        let firstNewsMedia = firstNews?.media.first
        let metadata = firstNewsMedia?.metadata
        let firstMetadata = metadata?.first
        
        XCTAssertNotNil(apiResult)
        XCTAssertNotNil(firstNews)
        XCTAssertNotNil(firstNewsMedia)
        XCTAssertNotNil(metadata)
        XCTAssert(metadata!.count == 3)
        XCTAssert(firstMetadata?.format == .thumbnail)
    }
    
    func testEmptyWorkingJson() {
        let jsonData = emptyWorkingTestJson.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        
        let apiResult = try? jsonDecoder.decode(NyTimesApiResultModel.self, from: jsonData)
        
        XCTAssertNotNil(apiResult)
        XCTAssert(apiResult!.news.isEmpty)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
