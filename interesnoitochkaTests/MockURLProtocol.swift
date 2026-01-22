//
//
// MockURLProtocol.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("MockURLProtocol.handler is not set")
        }

        let (response, data) = handler(request)

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

        if let data {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
