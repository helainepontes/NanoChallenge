//
//  URLSessionMock.swift
//  NanoIndividualTests
//
//  Created by Helaine Pontes on 22/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    var lastUrl: URL?
    override init() {
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer { completionHandler(nil, nil, nil) }
        lastUrl = request.url
        return DataTaskMock() 
    }
}
