//
//  NyTimesApiTests.swift
//  NyTimesMostPopularTests
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import XCTest
@testable import NyTimesMostPopular

class NyTimesApiTests: XCTestCase {
    
    func testApiFetch() {
        let api = NyTimesApi()
        
        api.fetchMostViewed(section: .all, timePeriod: .day,
                            onSuccess: { (apiResultModel) in
            XCTAssert(apiResultModel.status == "OK")
        }) { (error) in
            if let decodingError = error as? DecodingError {
                XCTAssert(false, "Decoding error: \(decodingError.errorDescription ?? "")")
            }
            
            XCTAssert(false, "Check internet connection.")
        }
    }
    
}
