//
//  NetworkingRequestTest.swift
//  NanoIndividualTests
//
//  Created by Helaine Pontes on 22/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import XCTest
@testable import NanoIndividual

class NetworkingRequestTest: XCTestCase {
    func test_networkingRequest_urlForCategories_toBeValid() {
        //given
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")
        let expect = expectation(description: "getCatrgories")
        let session = URLSessionMock()
        
        NetworkRequest().getCategories(session: session) { _ in
            XCTAssertEqual(url, session.lastUrl)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
}
